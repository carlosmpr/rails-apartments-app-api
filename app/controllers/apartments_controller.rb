class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
    def index
        apartments = Apartment.all
        render json: apartments, only: [:id, :number]
    end


    def show
        apparment = find_apartment
        render json: apparment.detail
    end


    def create
        begin
            apartment = Apartment.create!(number: params[:number])
            render json: apartment.detail
        rescue ActiveRecord::RecordInvalid=> exception
            render json: exception
        end
    end



    def update
        begin
            apartment = find_apartment
            apartment.update(number: params[:number])
            render json: apartment.detail
        rescue ActiveRecord::RecordInvalid=> exception
            render json: exception
        end
    end



    def destroy
        apparment = find_apartment
        apparment.destroy
        render json: {message:'Operation completed', status:200}
    end


    private
    def find_apartment
         Apartment.find(params[:id])
    end

  

    
    def not_found_response
        render json: {message:'Not found'},  status: :not_found
    end
end
