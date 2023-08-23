import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

class Player {
    private int playerId;
    private String name;
    private int teamId;

    public Player(int playerId, String name, int teamId) {
        this.playerId = playerId;
        this.name = name;
        this.teamId = teamId;
    }

    public int getPlayerId() {
        return playerId;
    }

    public String getName() {
        return name;
    }

    public int getTeamId() {
        return teamId;
    }
}



class Team {
    private int teamId;
    private String name;
    private int leagueId;
    private List<Player> players;

    public Team(int teamId, String name, int leagueId) {
        this.teamId = teamId;
        this.name = name;
        this.leagueId = leagueId;
        players = new ArrayList<>();
    }

    public int getTeamId() {
        return teamId;
    }

    public String getName() {
        return name;
    }

    public int getLeagueId() {
        return leagueId;
    }

    public void addPlayer(Player player) {
        players.add(player);
    }

    public List<Player> getPlayers() {
        return players;
    }
}

class Match {
    private Team team1;
    private Team team2;
    private int team1Goals;
    private int team2Goals;
    private Team winner;

    public Match(Team team1, Team team2) {
        this.team1 = team1;
        this.team2 = team2;
    }

    public void play() {
        Random random = new Random();

        team1Goals = random.nextInt(5);
        team2Goals = random.nextInt(5);

        if (team1Goals > team2Goals) {
            winner = team1;
        } else if (team2Goals > team1Goals) {
            winner = team2;
        }
    }

    public String getWinnerName() {
        if (winner != null) {
            return winner.getName();
        }
        return "Draw";
    }

    public String getFullTimeScore() {
        return team1.getName() + " " + team1Goals + " - " + team2Goals + " " + team2.getName();
    }

    public List<Player> getGoalScorers() {
        List<Player> goalScorers = new ArrayList<>();

        for (int i = 0; i < team1Goals; i++) {
            if (i < team1.getPlayers().size()) {
                goalScorers.add(team1.getPlayers().get(i));
            }
        }

        for (int i = 0; i < team2Goals; i++) {
            if (i < team2.getPlayers().size()) {
                goalScorers.add(team2.getPlayers().get(i));
            }
        }

        return goalScorers;
    }

}

class League {
    private String name;
    private List<Team> teams;

    public League(String name) {
        this.name = name;
        teams = new ArrayList<>();
    }

    public void addTeam(Team team) {
        teams.add(team);
    }

    public List<Team> getTeams() {
        return teams;
    }

    public Match getRandomMatch() {
        Random random = new Random();
        int teamIndex1 = random.nextInt(teams.size());
        int teamIndex2 = random.nextInt(teams.size());

        while (teamIndex2 == teamIndex1) {
            teamIndex2 = random.nextInt(teams.size());
        }

        Team team1 = teams.get(teamIndex1);
        Team team2 = teams.get(teamIndex2);

        return new Match(team1, team2);
    }

    public String getName() {
        return name;
    }
}

public class FootballGame {
    public static void main(String[] args) {
        Team teamLiverpool = new Team(1, "Liverpool", 1);           // Assuming team ID is 1, associated with league ID 1


        Team teamBarcelona = new Team(2, "Barcelona", 1);           // Assuming team ID is 2, associated with league ID 1

        League premierLeague = new League("Premier League");
        premierLeague.addTeam(teamLiverpool);
        premierLeague.addTeam(teamBarcelona);

        Player mohammedSalah = new Player(1, "Mohammed Salah", 1);  // Assuming player ID is 1, associated with team ID 1
        Player lionelMessi = new Player(2, "Lionel Messi", 1);      // Assuming player ID is 2, associated with team ID 1
        Player cristianoRonaldo = new Player(3, "Cristiano Ronaldo", 2); // Assuming player ID is 3, associated with team ID 2
        Player neymar = new Player(4, "Neymar", 2);                 // Assuming player ID is 4, associated with team ID 2

        teamLiverpool.addPlayer(mohammedSalah);
        teamLiverpool.addPlayer(lionelMessi);
        teamBarcelona.addPlayer(cristianoRonaldo);
        teamBarcelona.addPlayer(neymar);

        Match match = premierLeague.getRandomMatch();
        match.play();

        System.out.println("Match Result:");
        System.out.println("Winner: " + match.getWinnerName());
        System.out.println("Score: " + match.getFullTimeScore());

        List<Player> goalScorers = match.getGoalScorers();
        System.out.println("Goal Scorers:");
        for (Player scorer : goalScorers) {
            System.out.println(scorer.getName());
        }

        // Add data to PostgreSQL database (Assuming the database is set up and connection is established)
        try (Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "12345789")) {


            // Insert teams


            // Insert leagues
            String selectPlayersQuery = "SELECT * FROM Players";
            try (PreparedStatement statement = connection.prepareStatement(selectPlayersQuery)) {
                ResultSet resultSet = statement.executeQuery();
                System.out.println("Players with Their Teams:");
                while (resultSet.next()) {
                    int playerId = resultSet.getInt("player_id");
                    String playerName = resultSet.getString("name");
                    int teamId = resultSet.getInt("team_id");
                    System.out.println("Player ID: " + playerId + ", Name: " + playerName + ", Team ID: " + teamId);
                }
            }

            // Print all teams with their leagues
            String selectTeamsQuery = "SELECT * FROM Teams";
            try (PreparedStatement statement = connection.prepareStatement(selectTeamsQuery)) {
                ResultSet resultSet = statement.executeQuery();
                System.out.println("\nTeams with Their Leagues:");
                while (resultSet.next()) {
                    int teamId = resultSet.getInt("team_id");
                    String teamName = resultSet.getString("name");
                    int leagueId = resultSet.getInt("league_id");
                    System.out.println("Team ID: " + teamId + ", Name: " + teamName + ", League ID: " + leagueId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
