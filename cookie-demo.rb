enable :sessions

get '/' do
  session['count'] ||= 0
  session['count'] += 1
  erb session['count'].to_s
end
