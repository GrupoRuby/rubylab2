Puntodecontrol::Admin.controllers :clientes do
  get :index do
    @title = "Clientes"
    @clientes = Cliente.all
    render 'clientes/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'cliente')
    @cliente = Cliente.new
    render 'clientes/new'
  end

  post :create do
    @cliente = Cliente.new(params[:cliente])
    if @cliente.save
      @title = pat(:create_title, :model => "cliente #{@cliente.id}")
      flash[:success] = pat(:create_success, :model => 'Cliente')
      params[:save_and_continue] ? redirect(url(:clientes, :index)) : redirect(url(:clientes, :edit, :id => @cliente.id))
    else
      @title = pat(:create_title, :model => 'cliente')
      flash.now[:error] = pat(:create_error, :model => 'cliente')
      render 'clientes/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "cliente #{params[:id]}")
    @cliente = Cliente.find(params[:id])
    if @cliente
      render 'clientes/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'cliente', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "cliente #{params[:id]}")
    @cliente = Cliente.find(params[:id])
    if @cliente
      if @cliente.update_attributes(params[:cliente])
        flash[:success] = pat(:update_success, :model => 'Cliente', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:clientes, :index)) :
          redirect(url(:clientes, :edit, :id => @cliente.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'cliente')
        render 'clientes/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'cliente', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Clientes"
    cliente = Cliente.find(params[:id])
    if cliente
      if cliente.destroy
        flash[:success] = pat(:delete_success, :model => 'Cliente', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'cliente')
      end
      redirect url(:clientes, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'cliente', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Clientes"
    unless params[:cliente_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'cliente')
      redirect(url(:clientes, :index))
    end
    ids = params[:cliente_ids].split(',').map(&:strip)
    clientes = Cliente.find(ids)
    
    if Cliente.destroy clientes
    
      flash[:success] = pat(:destroy_many_success, :model => 'Clientes', :ids => "#{ids.join(', ')}")
    end
    redirect url(:clientes, :index)
  end
end
