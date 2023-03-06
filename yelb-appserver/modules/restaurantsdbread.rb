require 'pg'
require 'pg_ext'
require 'aws-sdk-dynamodb'

def restaurantsdbread(restaurant)
    if ($yelbddbrestaurants != nil && $yelbddbrestaurants != "") then
        dynamodb = Aws::DynamoDB::Client.new(region: $awsregion)
        params = {
            table_name: $yelbddbrestaurants,
            key: {
                name: restaurant
            }
        }
        restaurantrecord = dynamodb.get_item(params)
        restaurantcount = restaurantrecord.item['restaurantcount']
    else 
        con = PG.connect  :host => $yelbdbhost,
                        :port => $yelbdbport,
                        :dbname => $yelbdbname,
                        :user => $yelbdbuser,
                        :password => $yelbdbpassword
        con.exec "CREATE TABLE IF NOT EXISTS restaurants (name char(30),count integer,PRIMARY KEY (name))"
        con.exec "INSERT INTO restaurants (name, count) VALUES ('outback', 0) ON CONFLICT DO NOTHING"
        con.exec "INSERT INTO restaurants (name, count) VALUES ('bucadibeppo', 0) ON CONFLICT DO NOTHING"
        con.exec "INSERT INTO restaurants (name, count) VALUES ('chipotle', 0) ON CONFLICT DO NOTHING"
        con.exec "INSERT INTO restaurants (name, count) VALUES ('ihop', 0) ON CONFLICT DO NOTHING"
        con.prepare('statement1', 'SELECT count FROM restaurants WHERE name =  $1')
        res = con.exec_prepared('statement1', [ restaurant ])
        restaurantcount = res.getvalue(0,0)
        con.close
    end
    return restaurantcount.to_s
end 
