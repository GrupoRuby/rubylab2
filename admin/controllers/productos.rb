Puntodecontrol::Admin.controllers :productos do
  get :index do
    @title = "Productos"
    @productos = Producto.all
    render 'productos/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'producto')
    @producto = Producto.new
    render 'productos/new'
  end

  post :create do
    @producto = Producto.new(params[:producto])
    if @producto.save
      @title = pat(:create_title, :model => "producto #{@producto.id}")
      flash[:success] = pat(:create_success, :model => 'Producto')
      params[:save_and_continue] ? redirect(url(:productos, :index)) : redirect(url(:productos, :edit, :id => @producto.id))
    else
      @title = pat(:create_title, :model => 'producto')
      flash.now[:error] = pat(:create_error, :model => 'producto')
      render 'productos/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "producto #{params[:id]}")
    @producto = Producto.find(params[:id])
    if @producto
      render 'productos/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'producto', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "producto #{params[:id]}")
    @producto = Producto.find(params[:id])
    if @producto
      if @producto.update_attributes(params[:producto])
        flash[:success] = pat(:update_success, :model => 'Producto', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:productos, :index)) :
          redirect(url(:productos, :edit, :id => @producto.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'producto')
        render 'productos/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'producto', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Productos"
    producto = Producto.find(params[:id])
    if producto
      if producto.destroy
        flash[:success] = pat(:delete_success, :model => 'Producto', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'producto')
      end
      redirect url(:productos, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'producto', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Productos"
    unless params[:producto_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'producto')
      redirect(url(:productos, :index))
    end
    ids = params[:producto_ids].split(',').map(&:strip)
    productos = Producto.find(ids)
    
    if Producto.destroy productos
    
      flash[:success] = pat(:destroy_many_success, :model => 'Productos', :ids => "#{ids.join(', ')}")
    end
    redirect url(:productos, :index)
  end
end
