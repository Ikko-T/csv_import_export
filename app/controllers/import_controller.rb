class ImportController < ApplicationController
  User.import_csv(file: params[:file]) if params[:file].present?
  redirect_to users_path
end
