enum ColorEnum {
    red
    green
    blue
    yellow
}

class Participant {
    [String] $name
    [int] $Age
    [String] $Color
    [int] $UserID

    Participant ([string] $name, [int] $Age, [String] $color, [int] $UserID) {
        $this.name = $name
        $this.Age = $Age
        $this.Color = $Color
        $this.UserID = $UserID
   
    }

    [String] toString() {
        return "{0},{1},{2},{3}" -f $this.name, $this.Age, $this.Color, $this.UserId
    }

}