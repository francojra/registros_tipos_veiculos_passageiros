
# Registros de veículos por tipo ----------------------------------------------------------------------------------------------------------
# Autora do script: Jeanne Franco ----------------------------------------------------------------------------------------------------------
# Data: 16/08/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: https://ourworldindata.org/transport -----------------------------------------------------------------------------------------

# Sobre o conjunto de dados ----------------------------------------------------------------------------------------------------------------

### Os dados mostram os registros dos tipos de veículos de passageiros.
### Os dados estão discriminados por: petróleo, gás diesel, híbridos completos,
### híbridos elétricos plug-in e veículos com bateria totalmente elétrica.

# Pacotes necessários para as análises -----------------------------------------------------------------------------------------------------

library(tidyverse)
library(scales)
library(gridExtra)

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
  geom_bar(color = "black", fill = "#f03b20", 
           stat = "summary", fun = "mean") +
  scale_y_continuous(labels = comma) +
  labs(x = "Anos", y = "Bateria totalmente elétrica") +
  theme_bw(base_size = 13)
g1

g2 <- ggplot(veh1, aes(x = Year, y = plugin_hybrid_number)) +
  geom_bar(color = "black", fill = "#f03b20", 
           stat = "summary", fun = "mean") +
  scale_y_continuous(labels = comma) +
  labs(x = "Anos", y = "Híbridos elétricos plug-in") +
  theme_bw(base_size = 13)
g2

g3 <- ggplot(veh1, aes(x = Year, y = full_mild_hybrid_number)) +
  geom_bar(color = "black", fill = "#f03b20", 
           stat = "summary", fun = "mean") +
  scale_y_continuous(labels = comma) +
  labs(x = "Anos", y = "Híbridos completos") +
  theme_bw(base_size = 13)
g3

g4 <- ggplot(veh1, aes(x = Year, y = petrol_number)) +
  geom_bar(color = "black", fill = "#f03b20", 
           stat = "summary", fun = "mean") +
  scale_y_continuous(labels = comma) +
  labs(x = "Anos", y = "Petróleo") +
  theme_bw(base_size = 13)
g4

g5 <- ggplot(veh1, aes(x = Year, y = diesel_gas_number)) +
  geom_bar(color = "black", fill = "#f03b20", 
           stat = "summary", fun = "mean") +
  scale_y_continuous(labels = comma) +
  labs(x = "Anos", y = "Gás diesel") +
  theme_bw(base_size = 13)
g5

grid.arrange(g1, g2, g3, g4, g5)

#  title = "Registros de veículos de passageiros"