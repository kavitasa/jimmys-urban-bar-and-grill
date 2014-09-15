require 'sinatra'
require 'pony'
# require 'sinatra-flash'

class Jimmys < Sinatra::Application
  # register Sinatra::Flash
  enable :sessions

  attr_reader :db

  class << self
    attr_accessor :db
  end

  before do
    @db = self.class.db
  end
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/about-us' do
    erb :about_us
  end

  get '/about-us/edit' do
    erb :about_edit
  end

  post '/about-us/edit' do

  end

  patch '/about-us/edit' do

  end

  delete '/about-us/edit' do

  end

  get '/contact-us' do
    erb :contact_us
  end

  post '/contact-us' do
    Pony.subject_prefix("REGARDING JIMMY'S URBAN: ")
    Pony.mail ({
      :subject => params[:subject],
      :from    => params[:mail],
      :body    => params[:message],
      :to      => 'jimsuttonjimsutton@gmail.com',
      :via     => :sendmail
    })
    redirect '/'
  end

  get '/location' do
    erb :location
  end

  get '/menu' do
    # require 'pry'
    # binding.pry
    @sections = db[:menu_sections]
    @items    = db[:menu_items]
    erb :menu
  end


  get '/admin' do
    #if !session
      erb :login
    #else
      # redirect '/admin-menu'
    #end
  end

  post '/login' do
<<<<<<< HEAD

=======
    user = DB[:users][name: params[:user_name]]
    hashed_password = Digest::SHA2.hexdigest(
      params[:user_password]
    )
    if hashed_password == user[:user_password]
      session[:user_id] = user[:id]
      redirect '/admin'
    else
      "Username / Password not found"
    end
>>>>>>> adding post route for authentication and flash
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/admin-menu' do
    erb :admin_menu, locals: {:menu_items => db[:menu_items].to_a, :menu_sections => db[:menu_sections].to_a}
  end

  post '/admin-menu' do

    section_name        = params[:menu][:section_name]
    section_description = params[:menu][:section_description]

    name        = params[:menu][:item_name]
    description = params[:menu][:item_description]
    price       = params[:menu][:item_price]
    section     = params[:menu][:item_menu_section]
    # add FK for Section
    # section     = db[:menu_sections]
    if !section_name.nil? && !section_description.nil?
      db[:menu_sections].insert(:name => section_name, :details => section_description)
    end

    if !name.nil? && !description.nil? && !price.nil? && !section.nil?
      db[:menu_items].insert(:name => name, :description => description, :price => price, :menu_section_id => section)
    end

    # db[:menu_sections][:name].insert(section_name)
    # db[:menu_sections][:details].insert(section_description)
    # insert(section_description).into(db[:menu_sections][:section_description])
    # insert(section_name, section_description).into(db[:menu_sections]).where
    # insert(name, price, description).into(section).where(name = section[:name] && price = section[:price], && description = section[:desctiption])

    # db[:menu_sections][:details]    = params[:menu][:section_description]
    # db[:menu_items][:name]
    # db[:menu_items][:menu_section] = params[menu[menu_section]]
    # db[:menu_items][:menu_section] = params[menu[item_menu_section]]
    redirect '/admin-menu'
  end

  delete '/admin-menu/sections/:id' do |id|
    db[:menu_sections].where(id: id.to_i).delete
    redirect '/admin-menu'
  end

  get '/admin-menu/sections/:id/edit' do |id|
    # require 'pry'
    # binding.pry
    section = db[:menu_sections].where(id: id.to_i).to_a.first
    erb :edit_menu_section, locals: { menu_section: section }
  end

  patch '/admin-menu/sections/:id/edit' do |id|
    name    = params[:menu][:section_name]
    details = params[:menu][:section_description]
    db[:menu_sections].where(id: id.to_i).update(name: name, details: details)
    redirect '/admin-menu'
  end


  get '/admin-menu/items/:id/edit' do |id|
    section = db[:menu_items].where(id: id.to_i).first
    erb :edit_menu_item, locals: { menu_item: section }
  end

  patch '/admin-menu/items/:id/edit' do |id|
    name    = params[:menu][:item_name]
    details = params[:menu][:item_description]
    price   = params[:menu][:item_price]
    db[:menu_items].where(id: id.to_i).update(name: name, description: details, price: price)
    redirect '/admin-menu'
  end


  delete '/admin-menu/items/:id' do |id|
    db[:menu_items].where(id: id.to_i).delete
    redirect '/admin-menu'
  end


  not_found do
    erb :error
  end



   # private method
    # def items_in_section(menu_items, section_id)
        # menu_items.to_a
        # menu_items.collect{ |item| item[:menu_section_id] == section_id}
        #column_name
        # menu_section_id
    # end

end
