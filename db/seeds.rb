10.times do 
  alphabet = ('a'..'z').to_a
  name = alphabet.sample(rand * 10).join.capitalize
  price = (rand * 10).round 2
  description = ''
  10.times do 
    description += alphabet.sample(rand * 10).join + ' '
  end
  
  Item.create name: name, price: price, description: description
end