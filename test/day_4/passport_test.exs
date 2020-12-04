defmodule PassportTest do
  use ExUnit.Case

  describe "part 1: lenient_valid_count returns the count of passwords that have all reqd fields present" do
    test "works for the sample data" do
      input = [
        "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd",
        "byr:1937 iyr:2017 cid:147 hgt:183cm",
        "",
        "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884",
        "hcl:#cfa07d byr:1929",
        "",
        "hcl:#ae17e1 iyr:2013",
        "eyr:2024",
        "ecl:brn pid:760753108 byr:1931",
        "hgt:179cm",
        "",
        "hcl:#cfa07d eyr:2025 pid:166559648",
        "iyr:2011 ecl:brn hgt:59in"
      ]

      assert Passport.lenient_valid_count(input) == 2
    end

    test "works for the real data" do
      assert Passport.lenient_valid_count() == 250
    end
  end

  describe "part 2: strict_valid_count returns the count of valid passwords" do
    @tag :skip
    test "works for the sample data" do
      input1 = [
        "eyr:1972 cid:100",
        "hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926",
        "",
        "iyr:2019",
        "hcl:#602927 eyr:1967 hgt:170cm",
        "ecl:grn pid:012533040 byr:1946",
        "",
        "hcl:dab227 iyr:2012",
        "ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277",
        "",
        "hgt:59cm ecl:zzz",
        "eyr:2038 hcl:74454a iyr:2023",
        "pid:3556412378 byr:2007"
      ]

      assert Passport.strict_valid_count(input1) == 0

      input2 = [
        "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980",
        "hcl:#623a2f",
        "",
        "eyr:2029 ecl:blu cid:129 byr:1989",
        "iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm",
        "",
        "hcl:#888785",
        "hgt:164cm byr:2001 iyr:2015 cid:88",
        "pid:545766238 ecl:hzl",
        "eyr:2022",
        "",
        "iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719"
      ]

      assert Passport.strict_valid_count(input2) == 4
    end

    @tag :skip
    test "works for the real data" do
      assert Passport.strict_valid_count() == 42
    end
  end

  describe "all_reqd_fields?" do
    test "returns boolean" do
      assert Passport.all_reqd_fields?(%{
               "ecl" => "gry",
               "pid" => "860033327",
               "eyr" => "2020",
               "hcl" => "#fffffd",
               "byr" => "1937",
               "iyr" => "2017",
               "cid" => "147",
               "hgt" => "183cm"
             })

      # missing hgt
      refute Passport.all_reqd_fields?(%{
               "iyr" => "2013",
               "ecl" => "amb",
               "cid" => "350",
               "eyr" => "2023",
               "pid" => "028048884",
               "hcl" => "#cfa07d",
               "byr" => "1929"
             })

      assert Passport.all_reqd_fields?(%{
               "hcl" => "#ae17e1",
               "iyr" => "2013",
               "eyr" => "2024",
               "ecl" => "brn",
               "pid" => "760753108",
               "byr" => "1931",
               "hgt" => "179cm"
             })

      # missing cid & byr
      refute Passport.all_reqd_fields?(%{
               "hcl" => "#cfa07d",
               "eyr" => "2025",
               "pid" => "166559648",
               "iyr" => "2011",
               "ecl" => "brn",
               "hgt" => "59in"
             })
    end
  end

  describe "valid_byr?" do
    test "returns boolean if at least 1920 & at most 2002" do
      # four digits; at least 1920 and at most 2002
      assert Passport.valid_byr?(%{"byr" => "1920"})
      assert Passport.valid_byr?(%{"byr" => "1979"})
      assert Passport.valid_byr?(%{"byr" => "2002"})

      refute Passport.valid_byr?(%{"byr" => "1900"})
      refute Passport.valid_byr?(%{"byr" => "2050"})
      refute Passport.valid_byr?(%{"byr" => "1"})
      refute Passport.valid_byr?(%{"byr" => "foo"})
      refute Passport.valid_byr?(%{})
    end
  end

  describe "valid_iyr?" do
    @tag :skip
    test "returns boolean if TODO" do
      # four digits; at least 2010 and at most 2020
      assert Passport.valid_iyr?(%{"iyr" => "1920"})
      assert Passport.valid_iyr?(%{"iyr" => "1979"})
      assert Passport.valid_iyr?(%{"iyr" => "2002"})

      refute Passport.valid_iyr?(%{"iyr" => "1900"})
      refute Passport.valid_iyr?(%{"iyr" => "2050"})
      refute Passport.valid_iyr?(%{"iyr" => "1"})
      refute Passport.valid_iyr?(%{"iyr" => "foo"})
      refute Passport.valid_iyr?(%{})
    end
  end

  describe "valid_eyr?" do
    @tag :skip
    test "returns boolean if TODO" do
      # four digits; at least 2020 and at most 2030
      assert Passport.valid_eyr?(%{"eyr" => "1920"})
      assert Passport.valid_eyr?(%{"eyr" => "1979"})
      assert Passport.valid_eyr?(%{"eyr" => "2002"})

      refute Passport.valid_eyr?(%{"eyr" => "1900"})
      refute Passport.valid_eyr?(%{"eyr" => "2050"})
      refute Passport.valid_eyr?(%{"eyr" => "1"})
      refute Passport.valid_eyr?(%{"eyr" => "foo"})
      refute Passport.valid_eyr?(%{})
    end
  end

  describe "valid_hgt?" do
    @tag :skip
    test "returns boolean if TODO" do
      # A number followed by either cm or in...
      # If cm, the number must be at least 150 and at most 193.
      # If in, the number must be at least 59 and at most 76.
      assert Passport.valid_hgt?(%{"hgt" => "1920"})
      assert Passport.valid_hgt?(%{"hgt" => "1979"})
      assert Passport.valid_hgt?(%{"hgt" => "2002"})

      refute Passport.valid_hgt?(%{"hgt" => "1900"})
      refute Passport.valid_hgt?(%{"hgt" => "2050"})
      refute Passport.valid_hgt?(%{"hgt" => "1"})
      refute Passport.valid_hgt?(%{"hgt" => "foo"})
      refute Passport.valid_hgt?(%{})
    end
  end

  describe "valid_hcl?" do
    @tag :skip
    test "returns boolean if TODO" do
      # a # followed by exactly six characters 0-9 or a-f
      assert Passport.valid_hcl?(%{"hcl" => "1920"})
      assert Passport.valid_hcl?(%{"hcl" => "1979"})
      assert Passport.valid_hcl?(%{"hcl" => "2002"})

      refute Passport.valid_hcl?(%{"hcl" => "1900"})
      refute Passport.valid_hcl?(%{"hcl" => "2050"})
      refute Passport.valid_hcl?(%{"hcl" => "1"})
      refute Passport.valid_hcl?(%{"hcl" => "foo"})
      refute Passport.valid_hcl?(%{})
    end
  end

  describe "valid_ecl?" do
    @tag :skip
    test "returns boolean if TODO" do
      # exactly one of: amb blu brn gry grn hzl oth
      assert Passport.valid_ecl?(%{"ecl" => "1920"})
      assert Passport.valid_ecl?(%{"ecl" => "1979"})
      assert Passport.valid_ecl?(%{"ecl" => "2002"})

      refute Passport.valid_ecl?(%{"ecl" => "1900"})
      refute Passport.valid_ecl?(%{"ecl" => "2050"})
      refute Passport.valid_ecl?(%{"ecl" => "1"})
      refute Passport.valid_ecl?(%{"ecl" => "foo"})
      refute Passport.valid_ecl?(%{})
    end
  end

  describe "valid_pid?" do
    @tag :skip
    test "returns boolean if TODO" do
      # a nine-digit number, including leading zeroes
      assert Passport.valid_pid?(%{"pid" => "1920"})
      assert Passport.valid_pid?(%{"pid" => "1979"})
      assert Passport.valid_pid?(%{"pid" => "2002"})

      refute Passport.valid_pid?(%{"pid" => "1900"})
      refute Passport.valid_pid?(%{"pid" => "2050"})
      refute Passport.valid_pid?(%{"pid" => "1"})
      refute Passport.valid_pid?(%{"pid" => "foo"})
      refute Passport.valid_pid?(%{})
    end
  end

  describe "valid?" do
    @tag :skip
    test "returns boolean" do
      assert Passport.valid?(%{
               "iyr" => "2010",
               "hgt" => "158cm",
               "hcl" => "#b6652a",
               "ecl" => "blu",
               "byr" => "1944",
               "eyr" => "2021",
               "pid" => "093154719"
             })

      refute Passport.valid?(%{
               "hcl" => "dab227",
               "iyr" => "2012",
               "ecl" => "brn",
               "hgt" => "182cm",
               "pid" => "021572410",
               "eyr" => "2020",
               "byr" => "1992",
               "cid" => "277"
             })
    end
  end
end
