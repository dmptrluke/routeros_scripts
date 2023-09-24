# Function to normalise a string

:global convchr do={
    :local chr $1
    :if (([:typeof $chr] != "str") or ($chr = "")) do={ :return "" }
    # ascii length > conv length because escaped " $ \ and question mark
    :local ascii " !\"#\$%&'()*+,-./0123456789:;<=>\?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
    :local conv  "_____________-._0123456789_______abcdefghijklmnopqrstuvwxyz______abcdefghijklmnopqrstuvwxyz____"
    :local chrValue [:find $ascii [:pick $chr 0 1] -1]
    :if ([:typeof $chrValue] = "num") do={
        :return [:pick $conv $chrValue ($chrValue + 1)]
    } else={
        :return "_"
    }
}

:global convstr do={
    :global convchr
    :local string $1
    :if (([:typeof $string] != "str") or ($string = "")) do={ :return "" }
    :local lenstr [:len $string]
    :local constr ""
    :for pos from=0 to=($lenstr - 1) do={
        :set constr "$constr$[$convchr [:pick $string $pos ($pos + 1)]]"
    }
    :return $constr
}
