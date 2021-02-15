class Api::V1::FactsController < ApplicationController

    def index
        @facts = Fact.all
        render json: @facts
    end

    def create
        @fact = Fact.new(fact_params)
        if @fact.save
            render json: @fact
        else
            render error: { error: 'unable to create fact '}, status: 400
        end
    end


    private
    
    def fact_params
        params.require(:fact).permit(:body, :likes)
    end

end
