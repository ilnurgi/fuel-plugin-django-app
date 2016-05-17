DATABASES:
    default:
        ENGINE: <%= @database_engine %>
        NAME: <%= @database_name %>
        USER: <%= @database_role %>
        PASSWORD: <%= @database_password %>
        HOST: <%= @database_host %>
        PORT: <%= @database_port %>