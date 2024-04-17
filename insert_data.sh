#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
index=-1
while IFS=, read -r year round winner opponent winner_goals opponent_goals; do
if [ $year != 'year' ]
  then
  #Agrega equipos a la tabla teams
  $($PSQL "INSERT INTO teams (name) VALUES ('$winner') ON CONFLICT (name) DO NOTHING")
  $($PSQL "INSERT INTO teams (name) VALUES ('$opponent') ON CONFLICT (name) DO NOTHING")
  #Guardar el id del perdedor y el ganador
  winner_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$winner'")
  opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$opponent'")
  #Guarda todo en la tabla games
  $($PSQL "INSERT INTO games (year,round,opponent_id,winner_id, winner_goals, opponent_goals) VALUES($year,'$round',$opponent_id,$winner_id,$winner_goals, $opponent_goals)")
  index=$((index + 1))
fi
    # Ejemplo de manipulación de los datos
done < games.csv