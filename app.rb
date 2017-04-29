require 'sinatra'
require_relative "hangman.rb"
enable :sessions
get '/' do
	erb :index
end 
post '/player_names' do 
	player1 = params[:player1]
	player2 = params[:player2]
	"Player 1 is #{player1} and Player 2 is #{player2}"
	redirect '/password?player1=' + player1 + '&player2=' + player2
end
get '/password' do
	player1 = params[:player1]
	player2 = params[:player2]
	erb :password, locals: {p1_name: player1, p2_name: player2}
end	
post '/secretword' do
	password = params[:word]
	session[:game]=Hangman.new(password)
	player1 = params[:player1]
	player2 = params[:player2]
		# "player 1 is #{player1} and player 2 is #{player2} and secret word is #{password}"
	redirect '/guessing?player1=' + player1 + '&player2=' + player2
	end
get '/guessing' do
	player1 = params[:player1]
	player2 = params[:player2]
	erb :guessing, locals:{p1_name: player1, p2_name: player2, blank: session[:game].correct_blank, array: session[:game].guessed,message2:"", message:"pick a letter",counter: session[:game].counter}
end 

post '/guess' do
	player1 = params[:player1]
	player2 = params[:player2]
	choice = params[:letter].upcase
	
		if  session[:game].available_guess(choice) == true
			session[:game].update_guessed(choice)
			session[:game].make_move(choice)	
				if  session[:game].loser == true
					redirect '/loser?player1=' + player1 + '&player2=' + player2
				elsif 
					session[:game].winner == true
					redirect '/winner?player1=' + player1 + '&player2=' + player2
				end	

			redirect '/guessing?player1=' + player1 + '&player2=' + player2

		else
			erb :guessing, locals:{p1_name:player1, p2_name:player2, blank: session[:game].correct_blank ,array: session[:game].guessed, message2: "Wrong Guess",message: "", counter: session[:game].counter}
		end
end		
get "/loser" do
	player1 = params[:player1]
	player2 = params[:player2]
		erb :loser, locals:{blank: session[:game].name, p1_name:player1, p2_name:player2, word: session[:game].name}
		
end
get "/winner" do
	player1 = params[:player1]
	player2 = params[:player2]
	erb :winner, locals:{blank: session[:game].name, p1_name: player1, p2_name: player2}
end	


