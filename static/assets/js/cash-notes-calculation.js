document.addEventListener("DOMContentLoaded", function() {
    const inputs = document.querySelectorAll('.cash-input');

    function calculateTotal() {
        let grandTotal = 0;
        inputs.forEach(input => {
            let quantity = parseInt(input.value) || 0;
            let value = parseInt(input.getAttribute("data-value"));
            let total = quantity * value;
            input.closest("tr").querySelector(".cash-total").textContent = total;
            grandTotal += total;
        });
        document.getElementById("grand-total").textContent = grandTotal;
    }

    inputs.forEach(input => {
        input.addEventListener("input", calculateTotal);
    });
});
