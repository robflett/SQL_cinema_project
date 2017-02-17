require_relative( './../models/customer.rb' )
require_relative( './../models/films.rb' )
require_relative( './../models/tickets.rb' )

require( 'pry' )




customer1 = Customer.new({ 'name' => 'Arron Hubber', 'funds' => 65})
customer1.save()

customer2 = Customer.new({ 'name' => 'Life Raluy', 'funds' => 70})
customer2.save()

customer3 = Customer.new({ 'name' => 'Dougie Craigie', 'funds' => 50})
customer3.save()



film1 = Film.new({ 'title' => 'LEGO Batman', 'price' => 10})
film1.save()

film2 = Film.new({ 'title' => 'Hidden Figures', 'price' => 12})
film2.save()

film3 = Film.new({ 'title' => 'Sing', 'price' => 8})
film3.save()



ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()

ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film1.id})
ticket3.save()

ticket4 = Ticket.new({ 'customer_id' => customer2, 'film_id' => film3.id})
ticket4.save()



binding.pry


nil