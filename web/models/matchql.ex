defmodule GraphQLTest do
  alias GraphQL.Type.{ObjectType, List, NonNull, ID, String, Int, Boolean}
  alias GraphQLTest.{Match, Game}

  defmodule Match do
    def type do
      %ObjectType{
        name: "Match",
        description: "A matchup of two teams in the ATL RLC",
        fields: %{
          week_number: %{type: %Int{}},
          games: %{type: %List{ofType: Game}}
        }
      } 
    end
  end
  
  defmodule Game do
    def type do
      %ObjectType{
        name: "Game",
        description: "A single game",
        fields: %{
          game_number: %{type: %Int{}}
        }
      }
    end
  end


  def schema do
    %GraphQL.Schema{
      query: %ObjectType{
        name: "query",
        fields: %{
          match: %{
            type: %List{ofType: Match},
            description: "A match in the ATL RLC",
            args: %{id: %{type: %ID{}, description: "ID of the match"}},
            resolve: {GraphQLTest, :match}
          }
        }
      }
    }
  end

  def match(_source, %{id: id}, _info) do
    RocketleaguePhoenix.Match.find_by_id(id)
  end

  # def match(_source, _args, _info) do
  #   RocketleaguePhoenix.Match.all
  # end
end