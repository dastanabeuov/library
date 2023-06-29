Rails.application.config.active_storage.previewers << ActiveStorage::Previewer::MuPDFPreviewer
# => [ ActiveStorage::Previewer::PopplerPDFPreviewer, ActiveStorage::Previewer::MuPDFPreviewer, ActiveStorage::Previewer::VideoPreviewer ]
