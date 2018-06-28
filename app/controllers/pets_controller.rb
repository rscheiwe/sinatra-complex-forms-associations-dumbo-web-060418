class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    # binding.pry
    @pet = Pet.create(params[:pet])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  # post '/pets/:id' do
  #   # binding.pry
  #   @pet = Pet.find(params[:id])
  #   @pet.update(params["pet"])
  #   if !params[:new_owner_name].empty?
  #     @pet.owner = Owner.create(name: params["owner"]["name"])
  #   end
  #   @pet.save
  #   redirect to "pets/#{@pet.id}"
  # end
  #
  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    if params[:owner_name] == ""
      @pet.name = params[:pet_name]
      existing_owner = Owner.find_by(name: params[:owner][:name])
      @pet.owner_id = existing_owner.id
      @pet.save
    else
      @pet.name = params[:pet_name]
      new_owner = Owner.create(name: params[:owner_name])
      @pet.owner = new_owner
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
