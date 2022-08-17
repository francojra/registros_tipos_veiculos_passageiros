
# Pacote dplyr -----------------------------------------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 09/08/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: https://github.com/rstudio/cheatsheets/blob/main/data-transformation.pdf -----------------------------------------------------

# Introdução -------------------------------------------------------------------------------------------------------------------------------

### As funções do dplyr trabalha com pipes dados organizados (tidy data).

library(dplyr)

# Summarise Cases --------------------------------------------------------------------------------------------------------------------------

### Aplica funções de resumos a colunas para criar novas tabelas de
### estatísticas resumos. Funções de resumo toma vetores como input
### e retorna um valor, por exemplo, cálculos de médias, desvios-
### padrão e erros-padrão.

## Função summarise:

### Computa tabelas de resumos.

summarise(mtcars, media = mean(mpg))

## Função count:

### Conta número de linhas de cada grupo definido pelas variáveis...
### Também tally().

count(mtcars, cyl)

# Group Cases ------------------------------------------------------------------------------------------------------------------------------

## Função group_by:

### Use 'group_by' para criar uma agrupada cópia de uma tabela agrupada
### por colunas. As funções do dplyr irão manipular cada grupo separadamente
### e combinar os resultados.

mtcars %>%
  group_by(cyl) %>%
  summarise(media = mean(mpg))

## Função rowwise:

### Agrupa dados em individuais linhas. Funções do dplyr irão computar
### os resultados para cada linha. Também aplicar funções para list-columns.

starwars %>%
  rowwise() %>%
  mutate(film_count = length(films)) %>%
  View()

## Função ungroup:

### Retorna uma cópia de tabela ungrouped.

ungroup(mtcars) %>%
  View()

# Manipulate Cases -------------------------------------------------------------------------------------------------------------------------

## Extração de casos em linhas. 

### As funções de linhas retornam um subconjuntos
### de linhas como uma nova tabela.

## Função filter:

### Extrai linhas que atingem o critério lógico.

filter(mtcars, mpg > 20)

## Função distinct:

### Remove linhas com valores duplicados.

distinct(mtcars, gear)

## Função slice:

### Seleciona linhas por posição.

slice(mtcars, 10:15)

## Função slice_sample:

### Seleciona linhas randomicamente. Usa 'n' para selecionar um número de
### linhas.

slice_sample(mtcars, n = 5, replace = TRUE)

## Função slice_min e slice_max:

### Seleciona linhas com os mais baixos e mais altos valores.

slice_min(mtcars, mpg, prop = 0.25)

## Função slice_head e slice_tail:

### Seleciona as primeiras ou últimas linhas.

slice_head(mtcars, n = 5)

# Operadores lógicos e booleanos para usar com a função filter -----------------------------------------------------------------------------

## ==
## !=
## <
## >
## <=
## >=
## is.na()
## !is.na()
## %in%
## !
## |
## &
## xor()

## Arrange cases

## Função arrange:

### Ordena linhas por valores de uma coluna ou colunas (do menor para o
### maior). Use desc() para ordenar do maior para o menor valor.

arrange(mtcars, mpg)
arrange(mtcars, desc(mpg))

## Add cases

## Função add_row:

### Adiciona uma ou mais linhas para a tabela.

add_row(cars, speed = 1, dist = 1)

# Manipulate Variables ---------------------------------------------------------------------------------------------------------------------

## Extract variables

### Funções para colunas retorna um conjunto de colunas como um novo vetor
### ou tabela.

## Função pull:

### Extrai colunas como vetores, por nome ou índice.

pull(mtcars, wt)

## Funão select:

### Extrai colunas como uma tabela.

select(mtcars, mpg, wt)

## Função relocate:

### Move colunas para uma nova posição.

relocate(mtcars, mpg, cyl, .after = last_col())

# Use esses auxiliares com select() e across() ---------------------------------------------------------------------------------------------

select(mtcars, contains(match = "carb"))

select(mtcars, ends_with(match = "yl"))

select(mtcars, starts_with(match = "c"))

select(mtcars, num_range("", 1:5))

select(mtcars, all_of("cyl")) #  É para uma selecção rigorosa. Se 
# alguma das variáveis do vector de caracteres estiver em falta, 
# é atirado um erro.

vars <- c("Sepal.Length", "Sepal.Width")
iris %>% select(all_of(vars))
starwars %>% select(all_of(vars)) # Se qualquer variável estiver faltando,
# um erro é acusado.

select(mtcars, any_of("gear", vars = NULL)) # Doesn't check for 
# missing variables. It is especially useful with negative selections,
# when you would like to make sure a variable is removed.

iris %>% select(-any_of(vars))

select(mtcars, matches("c")) # Retorna todas as variaveis que apresentam a letra "c".

select(mtcars, mpg:hp) # Seleciona colunas entre 'mpg' e 'hp'.

select(mtcars, -gear) # Seleciona todas as colunas, menos a variável 'gear'

select(mtcars, everything())

# Manipular múltiplas variáveis de uma vez -------------------------------------------------------------------------------------------------

## Função summarise:

### Resume ou modifica (mutate) múltiplas colunas da mesma forma.

summarise(mtcars, across(everything(), mean))

## Função transmute:

### Computa colunas em linhas.

transmute(rowwise(mtcars), total = sum(c_across(1:2))) # Soma cada linha
# das colunas de 1 a 2 (1:2).

# Criar novas variáveis --------------------------------------------------------------------------------------------------------------------

### Aplica funções vetorizadas para as colunas. Funções vetorizadas
### tomam vetores como input e retorna vetores de mesmo comprimento
### como output.

## Função mutate:

### Computa novas colunas.

mutate(mtcars, gpm = 1/mpg)

## Função transmute:

### Computa novas colunas e corta outras.

transmute(mtcars, gpm = 1/mpg)

## Função rename:

### Renomeia colunas. Use rename_with para renomear com uma função.

rename(cars, distance = dist)
rename_with(cars, toupper)
rename_with(iris, ~ tolower(gsub(".", "_", .x, fixed = TRUE)))

# Summary functions ------------------------------------------------------------------------------------------------------------------------

## Para usar com summarise(). summarise() aplica funções summary para colunas para criar uma nova
### tabela. Funções summary toma vetores como input e retorna simples
### valores como output. 

## count

## n(): número de valores/linhas.

summarise(iris, n())

## n_distinct: número de valores únicos.

summarise(iris, n_distinct())

## sum(!is.na()): número de linhas sem NAs.

summarise(iris, sum(!is.na(Species)))

## Position

## mean(): calcula a média, também mean(!is.nas()).

summarise(iris, mean(Petal.Length))

## median(): calcula a mediana.

summarise(iris, median(Sepal.Length))

## Order

## first(): retorna primeiro valor.

summarise(iris, first(Sepal.Length))

## last(): retorna último valor.

summarise(iris, last(Sepal.Length))

## nth(): retorna o valor da nth linha.

summarise(iris, nth(Sepal.Length, 11))

## Rank: retorna quantis, valores máximos e mínimos

summarise(iris, quantile(Sepal.Length))

summarise(iris, min(Sepal.Length))

summarise(iris, max(Sepal.Length))

## Spread:

summarise(iris, IQR(Sepal.Length))

summarise(iris, mad(Sepal.Length))

summarise(iris, sd(Sepal.Length))

summarise(iris, var(Sepal.Length))

# Row Names --------------------------------------------------------------------------------------------------------------------------------

### Dados tidy não usa nome de linhas (rownames), que armazena 
### uma variável fora das colunas. Para trabalhar com rownames,
### primeiro mova elas para uma coluna.

## Função rownames_to_column:

### Mone nomes de linhas para uma coluna.

library(tibble)

a <- rownames_to_column(mtcars, var = "C")
a

## Função column_to_rownames:

### Move coluna para linhas.

column_to_rownames(a, var = "C")

## Função has_rownames:

### Verifica se existe linhas fora de uma coluna.

has_rownames(mtcars)

## Função remove_rownames:

### Remove as linhas que se apresentam fora de uma coluna.

remove_rownames(mtcars)

# Funções vetorizadas ----------------------------------------------------------------------------------------------------------------------

### Usado com mutate() e transmute() aplica vetorizadas funções para
### colunas, para criar novas colunas. Funções vetorizadas toma vetores
### como input e retorna vetores de mesmo comprimento como output.

## Função case_when:

### Multi-case com if_else().

library(tidyverse)

starwars %>%
  mutate(type = case_when(height > 200 | mass > 200 ~ "large",
                          species == "Droid" ~ "robot",
                          TRUE ~ "other")) %>%
  view()

# Combinação de tabelas --------------------------------------------------------------------------------------------------------------------

## Combinação de variáveis

## Função bind_cols: une duas tabelas lado a lado e retorna uma tabela
## única. O comprimento das colunas deve ser igual. Colunas não serão
## unidas por uma id. Então verifique se ambas as tabelas estão ordenadas
## antes de uni-las.

# Dados relacionais

### Une as tabelas pelas colunas em comuns. Corresponde os valores com as
### linhas correspondentes. Cada tipo de 'join' mantem uma combinação diferente.

## Função left_join: junta valores correspondentes de y a x.

## Função right_join: junta valores correspondentes de x a y.

## Função inner_join: une os dados e retem apenas linhas com valores
## correspondentes a ambas tabelas.

## Função full_join: une os dados e retem todos os valores e linhas.

## Combinando casos (junção de tabelas por linhas)

## Função bind_rows: tabelas unidas uma sobre a outra, retornando
## uma tabela única. É estabelecido uma coluna id para ligar as duas
## tabelas.

one <- starwars[1:4, ]
two <- starwars[9:12, ]
bind_rows(one, two)

## Operações de conjuntos

## Função setdiff: linhas que aparecem em x, mas não em y.

setdiff(one, two)

## Função intersect: linhas que aparecem em ambas tabelas x e y.

intersect(one, starwars)

## Função union: linhas que aparecem em x ou y (linhas duplicadas
## são removidas).

union(two, starwars)

## Função union: linhas que aparecem em x ou y (linhas duplicadas
## não são removidas).

union_all(two, starwars)
