# Use an official Elixir runtime as a parent image
FROM elixir:1.8.1

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
RUN mix local.hex --force

# Install rebar (Erlang build tool)
RUN mix local.rebar --force

# Compile the project
RUN mix do compile

CMD ["/app/entrypoint.sh"]