# frozen_string_literal: true

threads_count = ENV.fetch("RAILS_MAX_THREADS", 3)
threads(threads_count, threads_count)

port(ENV.fetch("PORT", 3000))

plugin(:tmp_restart)

pidfile(ENV["PIDFILE"]) if ENV["PIDFILE"]

workers(ENV.fetch("WEB_CONCURRENCY") { 0 }.to_i)

preload_app! if ENV["WEB_CONCURRENCY"].to_i > 0
