import Swal from 'sweetalert2'

export async function confirmAction({ title, text, confirmButtonText = 'Ya, lanjutkan', icon = 'warning' }) {
  const result = await Swal.fire({
    title,
    text,
    icon,
    showCancelButton: true,
    confirmButtonText,
    cancelButtonText: 'Batal',
    reverseButtons: true,
    focusCancel: true,
    buttonsStyling: false,
    customClass: {
      popup: 'rounded-4',
      confirmButton: 'btn btn-danger px-4 ms-2',
      cancelButton: 'btn btn-light border px-4',
    },
  })

  return result.isConfirmed
}

export const confirmDelete = (name) => confirmAction({
  title: 'Hapus data ini?',
  text: `"${name}" akan dihapus dan tindakan ini tidak dapat dibatalkan.`,
  confirmButtonText: 'Ya, hapus',
})
