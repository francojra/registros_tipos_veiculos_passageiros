
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
library("scales")

# Carregar dados ---------------------------------------------------------------------------------------------------------------------------

veh <- read.csv("new-vehicles-type-area.csv")
view(veh)
names(veh)

# Selecionar dados -------------------------------------------------------------------------------------------------------------------------

veh1 <- veh %>%
  select(-Code) %>%
  view()

# Gráficos ---------------------------------------------------------------------------------------------------------------------------------

options(scipen = 999)

g1 <- ggplot(veh1, aes(x = Year, y = battery_electric_number)) +
  geom_col() +
  scale_y_continuous(labels = comma)
g1

g2 <- ggplot(veh1, aes(x = Year, y = plugin_hybrid_number)) +
  geom_col() +
  scale_y_continuous(labels = comma)
g2

g3 <- ggplot(veh1, aes(x = Year, y = full_mild_hybrid_number)) +
  geom_col() +
  scale_y_continuous(labels = comma)
g3

g4 <- ggplot(veh1, aes(x = Year, y = petrol_number)) +
  geom_col() +
  scale_y_continuous(labels = comma)
g4

g5 <- ggplot(veh1, aes(x = Year, y = diesel_gas_number)) +
  geom_col() +
  scale_y_continuous(labels = comma)
g5

