defmodule DiscTest do
  use ExUnit.Case

  describe "total_weight" do
    test "returns the weight of the disc and all children" do
      disc = %Disc{
        weight: 1,
        children: [
          %Disc{
            weight: 39,
            children: [
              %Disc{weight: 2, children: []}
            ]
          },
          %Disc{
            weight: 7,
            children: []
          }
        ]
      }

      assert Disc.total_weight(disc) == 1 + 39 + 2 + 7
    end
  end

  describe "balanced?" do
    assert Disc.balanced?(%Disc{
             weight: 1,
             children: [
               %Disc{
                 weight: 66,
                 children: []
               },
               %Disc{
                 weight: 66,
                 children: []
               }
             ]
           })

    assert Disc.balanced?(%Disc{
             weight: 1,
             children: [
               %Disc{
                 weight: 45,
                 children: [
                   %Disc{
                     weight: 66,
                     children: []
                   },
                   %Disc{
                     weight: 66,
                     children: []
                   },
                   %Disc{
                     weight: 66,
                     children: []
                   }
                 ]
               },
               %Disc{
                 weight: 72,
                 children: [
                   %Disc{
                     weight: 57,
                     children: []
                   },
                   %Disc{
                     weight: 57,
                     children: []
                   },
                   %Disc{
                     weight: 57,
                     children: []
                   }
                 ]
               }
             ]
           })

    refute Disc.balanced?(%Disc{
             weight: 1,
             children: [
               %Disc{
                 weight: 60,
                 children: []
               },
               %Disc{
                 weight: 66,
                 children: []
               }
             ]
           })
  end
end
