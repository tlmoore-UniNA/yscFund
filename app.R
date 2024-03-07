# Load packages
library(shiny)
library(googledrive)
library(googlesheets4)
library(DT)

# GOOGLE SHEETS AUTHENTICATION ===============================================
options(
  # whenever there is one account token found, use the cached token
  gargle_oauth_email = TRUE,
  # specify auth tokens should be stored in a hidden directory ".secrets"
  gargle_oauth_cache = ".secrets"
)

# Load the table when the app is run
sheetID <- googledrive::drive_get("fundingOpps")$id
df <- read_sheet(sheetID, sheet="table")


# UI =========================================================================
ui <- fluidPage(
	titlePanel("CRS YSC Early Career Funding Opportunities"), # End title
#	sidebarLayout(
#		sidebarPanel(),
#		mainPanel(
	DT::dataTableOutput("fund_table")
#       ) # End mainPanel 
#	) # End sidebarLayout
) # End fluidPage


# SERVER =====================================================================
server <- function(input, output, session){
	output$fund_table = DT::renderDataTable(df, filter = "top")
} # End server
shinyApp(ui, server)

