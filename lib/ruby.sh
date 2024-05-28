alias j='jekyll --server --auto'

createtokens () {
  echo cqe_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo customer_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo customer_support_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo dsot_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo event_broker_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo fleet_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo inspection_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo insurance_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo lightico_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo scheduler_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo spre_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo subscription_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo validation_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo vehicle_listing_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
  echo zendesk_service_user=`ruby -rsecurerandom -e "puts test=SecureRandom.base64(12)"`
}