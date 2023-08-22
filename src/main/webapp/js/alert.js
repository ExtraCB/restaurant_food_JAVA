function showAlert(type, message) {
    Swal.fire({
        title: type,
        text: message,
        icon: type,
        confirmButtonText: 'Ok !'
    });
}