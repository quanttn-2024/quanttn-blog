module API
  module V1
    class Users < Grape::API
      resource :users do
        desc 'User login'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post :login do
          user = User.find_by(email: params[:email])
          if user && user.authenticate(params[:password])
            { token: 'fake-jwt-token', user_id: user.id }
          else
            error!('Unauthorized.', 401)
          end
        end

        desc 'Create a post'
        params do
          requires :title, type: String
          optional :content, type: String
          optional :image, type: String
        end
        post :create_post do
          authenticate!
          Post.create!({
            title: params[:title],
            content: params[:content],
            image: params[:image],
            user_id: current_user.id
          })
        end

        helpers do
          def authenticate!
            error!('Unauthorized. Invalid or expired token.', 401) unless headers['Authorization'] == 'fake-jwt-token'
          end

          def current_user
            @current_user ||= User.find(headers['User-Id'])
          end
        end
      end
    end
  end
end
