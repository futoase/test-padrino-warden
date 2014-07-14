TestPadrinoWarden::App.controllers :index do
  get :index, map: '/' do
    render :index
  end
end
