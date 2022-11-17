class ApplicationController < Sinatra::Base
    set :default_content_type, 'application/json'

    get '/cars' do
       cars = Car.all
       cars.to_json
    end 

    post '/new_car' do
     car = Car.create(
         make: params[:make],
         model: params[:model],
         image_url: params[:image_url],
         price: params[:price]
      )
      car.to_json
    end



   #  get '/cars/:make' do
   #      car = Car.find_by_make(params[:make])
        
   #      car.to_json(only: [:make, :model], include: {reviews: {only: [:comment, :score], include: {user: {only: [:full_name]}}}})
   #  end

    get '/cars/:id' do
      car = Car.find(params[:id])
      
      car.to_json(only: [:id,:make, :model], include: {reviews: {only: [:comment, :score], include: {user: {only: [:full_name]}}}})
  end

    get '/users' do
        users = User.all
        users.to_json
     end

     post '/new_users' do
        user = User.create(
           full_name: params[:full_name],
           gender: params[:gender],
           email_address: params[:email_address],
           password: params[:password]
        )
        user.to_json
      end

      # get "/users/:email_address" do
      #    user = User.find_by_email_address(params[:username])
      #    user.to_json(include: [:trips])
      # end

      post '/login' do
         user = User.find_by(:email_address => params[:email_address])
         if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect to "/reviews"
         else
            flash[:error] = "your credentials are invalid please sign up or try again."
            redirect to '/'
         end         
      end

     get '/reviews' do
        reviews = Review.all
        reviews.to_json
     end

     post '/new_review' do
        review = Review.create(
           score: params[:score],
           comment: params[:comment],
           car_id: params[:car_id],
           user_id: params[:user_id]
        )
        review.to_json   
      end 

      patch '/reviews/:id' do
         review = Review.find(params[:id])
         review.update(
           score: params[:score],
           comment: params[:comment]
         )
         review.to_json
      end

      delete '/reviews/:id' do
         # find the review using the ID
         review = Review.find(params[:id])
         # delete the review
         review.destroy
         # send a response with the deleted review as JSON
         review.to_json
      end

      delete '/cars/:id' do
         # find the review using the ID
         car = Car.find(params[:id])
         # delete the review
         car.destroy
         # send a response with the deleted review as JSON
         car.to_json
      end




   
end