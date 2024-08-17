FROM elixir:1.17.2-otp-27

RUN apt-get update && \
apt-get -y install sudo

ADD . /app

RUN mix local.hex --force \
&& mix local.rebar --force
RUN mix archive.install hex phx_new

WORKDIR /app

RUN cd ../

RUN mix deps.get

RUN mix compile

EXPOSE 4000

RUN mix clean

CMD sleep 10; echo 'foo'; mix ecto.setup; mix phx.server;