module TestPadrinoWarden
  class App < Padrino::Application
    register SassInitializer
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Warden
    register Padrino::Warden::Helpers

    enable :sessions

    set :auth_failute_path, '/sessions/login'
    set :auth_success_path, '/'

    Warden::Strategies.add(:password) do
      def valid?
        params['email'] || params['password']
      end

      def authenticate!
        account = Account.authenticate(
          params['email'], params['password']
        )
        account.nil? ? fail!('Invalid username of password') : success!(account)
      end
    end

    Warden::Manager.serialize_into_session { |account| account.email }
    Warden::Manager.serialize_from_session { |email| Account.where(email: email) }

    before do
      unless request.path == '/sessions/login'
        return redirect '/sessions/login' unless authenticated?
      end
    end
  end
end
