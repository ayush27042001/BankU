const apiBase = "https://api.banku.co.in/api/admin";
const apiBaseforDD = "https://api.banku.co.in/api/dropdowns";
let headerPage = 1, slabPage = 1, distPage = 1;
const pageSize = 5;

function loadServices() {
    $.get(`${apiBaseforDD}/services`, function (data) {
        const ddl = $("#serviceId");
        ddl.empty().append('<option value="">Select Service</option>');
        data.forEach(s => ddl.append(`<option value="${s.id}">${s.serviceName}</option>`));
    });
}

function loadProviders(serviceId) {
    $.get(`${apiBaseforDD}/providers?serviceCode=${serviceId}`, function (data) {
        const ddl = $("#providerId");
        ddl.empty().append('<option value="">Select Provider</option>');
        data.forEach(p => ddl.append(`<option value="${p.providerCode}">${p.providerName}</option>`));
    });
}

function loadOperators(serviceName) {
    $.get(`${apiBaseforDD}/operators?serviceName=${serviceName}`, function (data) {
        const ddl = $("#operatorId");
        ddl.empty().append('<option value="">Select Operator</option>');
        data.forEach(o => ddl.append(`<option value="${o.Id}">${o.OperatorName}</option>`));
    });
}

function loadCommissionRules(serviceId, providerId) {
    $.get(`${apiBaseforDD}/commission-rules?serviceId=${serviceId}&providerId=${providerId}`, function (data) {
        const ddl = $("#slabRuleId");
        ddl.empty().append('<option value="">Select Rule</option>');
        data.forEach(r => ddl.append(`<option value="${r.commissionRuleId}">${r.display}</option>`));
    });
}

function loadCommissionSlabs(ruleId) {
    if (!ruleId) return;
    $.get(`${apiBaseforDD}/commission-slabs?ruleId=${ruleId}`, function (data) {
        const ddl = $("#distSlabId");
        ddl.empty().append('<option value="">Select Slab</option>');
        data.forEach(s => ddl.append(`<option value="${s.commissionSlabId}">${s.display}</option>`));
    });
}

// Headers
function loadHeaders(page = 1) {
    $.get(`${apiBase}/commission-headers?page=${page}&pageSize=${pageSize}`, function (data) {
        const tbody = $("#headerTable tbody"); tbody.empty();
        data.items.forEach(h => {
            tbody.append(`<tr>
        <td>${h.commissionRuleId}</td>
        <td>${h.serviceId}</td>
        <td>${h.providerId}</td>
        <td>${h.operatorId || '-'}</td>
        <td>${h.isActive}</td>
        <td><button onclick="toggleHeader(${h.commissionRuleId},${h.isActive})">Toggle</button>
            <button onclick="deleteHeader(${h.commissionRuleId})">Delete</button></td>
      </tr>`);
        });
        $("#headerPage").text(data.Page);
    });
}

$("#addHeader").click(() => {
    const dto = { serviceId: $("#serviceId option:selected").text(), providerId: $("#providerId option:selected").val(), operatorId: $("#operatorId").val() ? parseInt($("#operatorId").val()) : null };
    if (!dto.serviceId || !dto.providerId) { alert("Service & Provider required"); return; }
    $.ajax({ url: `${apiBase}/commission-headers`, type: 'POST', contentType: 'application/json', data: JSON.stringify(dto), success: () => loadHeaders(headerPage), error: err => alert(err.responseText) });
});

function toggleHeader(id, current) {
    $.ajax({ url: `${apiBase}/commission-headers/${id}`, type: 'PUT', contentType: 'application/json', data: JSON.stringify({ isActive: !current }), success: () => loadHeaders(headerPage) });
}
function deleteHeader(id) { if (!confirm("Delete?")) return; $.ajax({ url: `${apiBase}/commission-headers/${id}`, type: 'DELETE', success: () => loadHeaders(headerPage) }); }
$("#prevHeader").click(() => { if (headerPage > 1) headerPage--; loadHeaders(headerPage); });
$("#nextHeader").click(() => { headerPage++; loadHeaders(headerPage); });

// Slabs
function loadSlabs(page = 1) {
    const ruleId = $("#slabRuleId").val(); if (!ruleId) return;
    $.get(`${apiBase}/commission-slabs/${ruleId}?page=${page}&pageSize=${pageSize}`, function (data) {
        const tbody = $("#slabTable tbody"); tbody.empty();
        data.items.forEach(s => {
            tbody.append(`<tr>
        <td>${s.commissionSlabId}</td>
        <td>${s.commissionRuleId}</td>
        <td><input type="number" value="${s.fromAmount}" class="editFrom" data-id="${s.commissionSlabId}"></td>
        <td><input type="number" value="${s.toAmount}" class="editTo" data-id="${s.commissionSlabId}"></td>
        <td><button class="saveSlab" data-id="${s.commissionSlabId}">Save</button>
            <button onclick="deleteSlab(${s.commissionSlabId})">Delete</button></td>
      </tr>`);
        });
        $(".saveSlab").click(function () {
            const id = $(this).data("id"), from = parseFloat($(`.editFrom[data-id=${id}]`).val()), to = parseFloat($(`.editTo[data-id=${id}]`).val());
            if (from >= to) { alert("From < To"); return; }
            $.ajax({ url: `${apiBase}/commission-slabs/${id}`, type: 'PUT', contentType: 'application/json', data: JSON.stringify({ fromAmount: from, toAmount: to }), success: () => loadSlabs(page), error: err => alert(err.responseText) });
        });
        $("#slabPage").text(data.Page);
    });
}

$("#addSlab").click(() => {
    const dto = { commissionRuleId: parseInt($("#slabRuleId").val()), fromAmount: parseFloat($("#fromAmount").val()), toAmount: parseFloat($("#toAmount").val()) };
    if (dto.fromAmount >= dto.toAmount) { alert("From < To"); return; }
    $.ajax({ url: `${apiBase}/commission-slabs`, type: 'POST', contentType: 'application/json', data: JSON.stringify(dto), success: () => loadSlabs(slabPage), error: err => alert(err.responseText) });
});
function deleteSlab(id) { if (!confirm("Delete slab?")) return; $.ajax({ url: `${apiBase}/commission-slabs/${id}`, type: 'DELETE', success: () => loadSlabs(slabPage) }); }
$("#prevSlab").click(() => { if (slabPage > 1) slabPage--; loadSlabs(slabPage); });
$("#nextSlab").click(() => { slabPage++; loadSlabs(slabPage); });

// Distributions
function loadDistributions(page = 1) {
    const slabId = $("#distSlabId").val(); if (!slabId) return;
    $.get(`${apiBase}/commission-distributions/${slabId}?page=${page}&pageSize=${pageSize}`, function (data) {
        const tbody = $("#distTable tbody"); tbody.empty();
        data.items.forEach(d => {
            tbody.append(`<tr>
        <td>${d.commissionDistributionId}</td>
        <td>${d.commissionSlabId}</td>
        <td>${d.userType}</td>
        <td><select class="editType" data-id="${d.commissionDistributionId}"><option value="1" ${d.commissionType === 1 ? 'selected' : ''}>FLAT</option><option value="2" ${d.commissionType === 2 ? 'selected' : ''}>PERCENT</option></select></td>
        <td><input type="number" step="0.01" value="${d.commissionValue}" class="editValue" data-id="${d.commissionDistributionId}"></td>
        <td><button class="saveDist" data-id="${d.commissionDistributionId}">Save</button>
            <button onclick="deleteDistribution(${d.commissionDistributionId})">Delete</button></td>
      </tr>`);
        });
        $(".saveDist").click(function () {
            const id = $(this).data("id"), type = parseInt($(`.editType[data-id=${id}]`).val()), val = parseFloat($(`.editValue[data-id=${id}]`).val());
            if (val <= 0) { alert("Value > 0"); return; }
            $.ajax({ url: `${apiBase}/commission-distributions/${id}`, type: 'PUT', contentType: 'application/json', data: JSON.stringify({ commissionType: type, commissionValue: val }), success: () => loadDistributions(page), error: err => alert(err.responseText) });
        });
        $("#distPage").text(data.Page);
    });
}

$("#addDistribution").click(() => {
    const dto = { commissionSlabId: parseInt($("#distSlabId").val()), userType: $("#userType").val(), commissionType: parseInt($("#commType").val()), commissionValue: parseFloat($("#commValue").val()) };
    if (!dto.userType || dto.commissionValue <= 0) { alert("All required"); return; }
    $.ajax({ url: `${apiBase}/commission-distributions`, type: 'POST', contentType: 'application/json', data: JSON.stringify(dto), success: () => loadDistributions(distPage), error: err => alert(err.responseText) });
});
function deleteDistribution(id) { if (!confirm("Delete?")) return; $.ajax({ url: `${apiBase}/commission-distributions/${id}`, type: 'DELETE', success: () => loadDistributions(distPage) }); }
$("#prevDist").click(() => { if (distPage > 1) distPage--; loadDistributions(distPage); });
$("#nextDist").click(() => { distPage++; loadDistributions(distPage); });

// Initial load
$(document).ready(function () {
    loadServices();

    $("#serviceId").change(function () {
        const serviceId = $("#serviceId option:selected").text();
        if (serviceId) loadProviders(serviceId);
        $("#slabRuleId").empty().append('<option value="">Select Rule</option>');
        $("#distSlabId").empty().append('<option value="">Select Slab</option>');
    });

    $("#providerId").change(function () {
        const serviceId = $("#serviceId option:selected").text();
        const providerId = $(this).val();
        if (serviceId && providerId) loadCommissionRules(serviceId, providerId);
        $("#distSlabId").empty().append('<option value="">Select Slab</option>');
    });

    $("#slabRuleId").change(function () {
        const ruleId = $(this).val();
        loadCommissionSlabs(ruleId);
    });
    loadHeaders(headerPage);
    $("#slabRuleId").change(() => loadSlabs(slabPage));
    $("#distSlabId").change(() => loadDistributions(distPage));
});
