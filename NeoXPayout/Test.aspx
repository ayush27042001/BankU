<%@ Page Title="" Language="C#" MasterPageFile="~/Neox.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="NeoXPayout.Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
     body { font-family: Arial, sans-serif; margin: 24px; background:#f7f7f7;}
     .card { background:white; padding:18px; border-radius:8px; box-shadow: 0 2px 6px rgba(0,0,0,0.08); max-width:900px; margin:0 auto;}
     .two-col { display:flex; gap:12px; }
     .col { flex:1; }
     label { display:block; margin-bottom:6px; font-weight:600; font-size:13px; }
     input[type="text"], textarea, select { width:100%; padding:8px 10px; border:1px solid #ddd; border-radius:6px; box-sizing:border-box; }
     .row { margin-bottom:12px; }
     .muted { color:#666; font-size:13px; }
     .btn { background:#0066cc; color:white; border:none; padding:10px 14px; border-radius:6px; cursor:pointer; font-weight:600;}
     .btn:disabled { opacity:.6; cursor:default; }
     pre { background:#111; color:#dff; padding:12px; border-radius:6px; overflow:auto; max-height:320px; }
     .response-area { margin-top:14px; }
     .small { font-size:12px; color:#555; }
       .device-select { display:flex; gap:10px; margin-bottom:10px; }
     .device-btn { background:#ccc; border:none; padding:8px 14px; border-radius:6px; cursor:pointer; }
     .device-btn.active { background:#0066cc; color:#fff; }
 </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div class="device-select">
    <button type="button" class="device-btn" onclick="selectDeviceBtn('Mantra', this)">Mantra L1</button>
    <button type="button" class="device-btn" onclick="selectDeviceBtn('Morpho', this)">Morpho L1</button>
    <button type="button" class="device-btn" onclick="selectDeviceBtn('Startek', this)">Startek L1</button>

    <button type="button" class="btn" onclick="return captureFingerprint();">
        Capture Fingerprint
    </button>

    <asp:HiddenField ID="hdnPidData" ValidateRequestMode="Disabled" runat="server" />
     
<asp:LinkButton 
    ID="lnkSaveFingerprint" 
    runat="server"
    OnClick="lnkSaveFingerprint_Click"
    Style="display:none;">
</asp:LinkButton>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    let selectedDevice = '';
    let finalUrl = '';
    let MethodCapture = '';
    let MethodInfo = '';
    let rdServiceInfo = '';
    let rdDiscovered = false;

    /* ---------------- Device Selection ---------------- */
    function selectDeviceBtn(id, btn) {
        selectedDevice = id;
        document.querySelectorAll('.device-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        console.log(`✅ Selected device: ${id}`);
    }

    /* ---------------- URL Builder ---------------- */
    function buildFullUrl(path) {
        if (!path) return '';
        if (path.startsWith('http')) return path;
        return finalUrl + (path.startsWith('/') ? path : '/' + path);
    }

    /* ---------------- RD Discovery ---------------- */
    async function discoverRdService(deviceType) {
        if (rdDiscovered) return;

        return new Promise((resolve, reject) => {
            const isHttps = location.protocol === 'https:';
            const baseUrl = isHttps ? 'https://127.0.0.1:' : 'http://127.0.0.1:';
            const ports = Array.from({ length: 21 }, (_, i) => 11100 + i);

            function tryPort(i) {
                if (i >= ports.length) return reject('RD Service not found');

                $.ajax({
                    url: baseUrl + ports[i],
                    type: 'RDSERVICE',
                    timeout: 2000,
                    success: function (data) {
                        const xml = new DOMParser().parseFromString(data, 'text/xml');
                        const rd = xml.querySelector('RDService');
                        if (!rd) return tryPort(i + 1);

                        const info = (rd.getAttribute('info') || '').toLowerCase();

                        if (
                            (deviceType === 'Mantra' && !info.includes('mantra')) ||
                            (deviceType === 'Morpho' && !info.includes('morpho')) ||
                            (deviceType === 'Startek' && !info.includes('startek'))
                        ) return tryPort(i + 1);

                        rdServiceInfo = info;
                        finalUrl = baseUrl + ports[i];

                        xml.querySelectorAll('Interface').forEach(n => {
                            if (n.getAttribute('id') === 'CAPTURE') MethodCapture = n.getAttribute('path');
                            if (n.getAttribute('id') === 'DEVICEINFO') MethodInfo = n.getAttribute('path');
                        });

                        console.log(`✅ RDService found (${rdServiceInfo}) at ${ports[i]}`);
                        rdDiscovered = true;
                        resolve();
                    },
                    error: () => tryPort(i + 1)
                });
            }
            tryPort(0);
        });
    }

    /* ---------------- PID XML by Device ---------------- */
    function getPidXml(deviceType) {
        if (deviceType === 'Mantra') {
            return `
<PidOptions ver="1.0">
  <Opts fCount="1" fType="2" format="0"
        pidVer="2.0" timeout="30000"
        env="P"
        wadh="E0jzJ/P8UopUHAieZn8CKqS4WPMi5ZSYXgfnlfkWjrc=" />
</PidOptions>`;
        }

        if (deviceType === 'Morpho') {
            return `
<PidOptions ver="1.0">
  <Opts fCount="1" fType="2" format="0"
        pidVer="2.0" timeout="30000"
        env="P"
        wadh="E0jzJ/P8UopUHAieZn8CKqS4WPMi5ZSYXgfnlfkWjrc=" />
</PidOptions>`;
        }

        // Startek
        return `
<PidOptions ver="1.0">
  <Opts fCount="1" fType="2" format="0"
        pidVer="2.0" timeout="30000"
        env="P" />
</PidOptions>`;
    }

    /* ---------------- Capture ---------------- */
    async function captureRdData(deviceType, retry = false) {
        await discoverRdService(deviceType);

        try {
            await $.ajax({
                url: buildFullUrl(MethodInfo),
                type: 'DEVICEINFO',
                timeout: 3000
            });
        } catch { }

        const pidXml = getPidXml(deviceType);

        let response;
        try {
            response = await $.ajax({
                url: buildFullUrl(MethodCapture),
                type: 'CAPTURE',
                dataType: 'text',
                data: pidXml,
                timeout: 35000,
                contentType: 'text/xml; charset=utf-8'
            });
        } catch (e) {
            throw new Error('CAPTURE request failed');
        }

        const xml = new DOMParser().parseFromString(response, 'text/xml');
        const resp = xml.querySelector('Resp');
        const errCode = resp?.getAttribute('errCode') || '';
        const errInfo = resp?.getAttribute('errInfo') || '';

        if (errCode && errCode !== '0') {
            if (errCode === '740' && !retry) {
                await new Promise(r => setTimeout(r, 2000));
                return captureRdData(deviceType, true);
            }
            throw new Error(`${errInfo} (Code: ${errCode})`);
        }

        return response;
    }

    /* ---------------- Button Handler ---------------- */
    async function captureFingerprint() {
        if (!selectedDevice) {
            alert('Please select a device');
            return false;
        }

        try {
            const pidXml = await captureRdData(selectedDevice);

            // Store PID XML
            document.getElementById('<%= hdnPidData.ClientID %>').value = pidXml;

        // Trigger hidden LinkButton (postback)
            document.getElementById('<%= lnkSaveFingerprint.ClientID %>').click();

        } catch (err) {
            alert('❌ Capture failed: ' + err.message);
        }
        return false;
    }

</script>

</asp:Content>
