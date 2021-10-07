
# 2018 - Electriciy generation by source

Europe <- read_csv("Desktop/Electricity generation by source - Europe.csv")
Europe <- Europe[c(7),c(2:14)]
Europe$total <- rowSums(Europe)
fossil <- Europe[,c(1:3)]
fossil$total <- rowSums(fossil)
ren <- Europe[,c(4,7:11,13)]
ren$total <- rowSums(ren)


#Shares
ren$total/Europe$total #33%
fossil$total/Europe$total #42%
Europe$Nuclear/Europe$total #22%


# 2018 - Primary energy supply by source
Europe_supply  <- Total_energy_supply_TES_by_source_Europe_1_

Europe_supply <- Europe_supply[c(7),c(2:8)]
Europe_supply$total <- rowSums(Europe_supply)
fossil <- Europe_supply[,c(1,2,7)]
fossil$total <- rowSums(fossil)
ren <- Europe_supply[,c(4,5,6)]
ren$total <- rowSums(ren)


#Shares
ren$total/Europe_supply$total #15%
fossil$total/Europe_supply$total #72%
Europe_supply$Nuclear/Europe_supply$total #12%
