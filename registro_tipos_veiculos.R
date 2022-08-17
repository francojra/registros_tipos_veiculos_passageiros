
# Registros de veículos por tipo ----------------------------------------------------------------------------------------------------------
# Autora do script: Jeanne Franco ----------------------------------------------------------------------------------------------------------
# Data: 16/08/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: https://ourworldindata.org/transport -----------------------------------------------------------------------------------------

# Sobre o conjunto de dados ----------------------------------------------------------------------------------------------------------------

### Os dados mostram os registros dos tipos de veículos de passageiros.
### Os dados estão discriminados por: petróleo, gás óleo, híbridos completos,
### híbridos elétricos plug-in e veículos com bateria totalmente elétrica.

# Pacotes necessários para as análises -----------------------------------------------------------------------------------------------------

library(tidyverse)

# Carregar dados ---------------------------------------------------------------------------------------------------------------------------

veh <- read.csv("new-vehicles-type-area.csv")
view(veh)


