#dataTable_user
serverAccueil<-
  function(input, output, session,globalInformation){
   
    output$recap_projet_Accueil <- renderText({
      progress <- shiny::Progress$new()
      # Make sure it closes when we exit this reactive, even if there's an error
      on.exit(progress$close())
      progress$set(message = paste0("get recap"), value = 0)
      progress$inc(1/2)
      
      
      contexte <- paste("a.Context \n",
"Le microbiome intestinal humain (i.e. ensemble des microorganismes habitant notre intestin) est fortement associé à notre santé.", 
"Sa dérégulation ou dysbiose peut être à l’origine ou refléter de multiples maladies chroniques humaines, comme l’obésité, le diabète,",
"différents cancers, les maladies inflammatoires de l’intestin etc. Ces espèces bactériennes sont difficiles à étudier car il est compliqué",
"de les isoler. La métagénomique est un nouveau domaine en forte explosion qui permet d’analyser très précisément la composition du ",
"microbiote ainsi que ses fonctions.",

"Différents projets internationaux ont généré de grands volumes de données de séquences génomiques (fragments d'ADN) à partir des milliers",
"d'échantillons de l'intestin humain. Ces données ont été utilisés pour reconstruire des catalogues de gènes de référence du microbiome ",
"humain représentent le contenu génétique des espèces microbiennes le constituant. Par des approches d’apprentissage non supervisés ",
"nous avons pu établir un catalogue d’espèces métagénomique (MGS), qui sont définis comme des ensembles de gènes provenant ",
"du même génome bactérien basé sur la corrélation des abondances des gènes sur plusieurs échantillons. Certaines de ces MGS sont des cibles",
"d’intérêt et peuvent aider à traiter différentes maladies chroniques.",
"Le problème est qu’on connaît peu de choses sur ces entités et qu’il y en a beaucoup qui ont des interactions entre elles.",
"Nous souhaiterions rassembler de la connaissance pertinente et construire des outils qui nous permettent de mieux voir et comprendre ",
"ces espèces et leur rôle dans la physiopathologie de l’hôte.",sep = "\n")
      
      objectif <- paste("\n\n\nb.	Objectifs \n",
"Le premier objectif de ce projet est de créer une base de données relativement simple permettant de ranger ",
"des annotations (fonctionnelles et autres) qui découlent des gènes individuels les composants, mais aussi au niveau ",
"de l’espèce (implication dans une maladie donnée, etc).",
"Le deuxième objectif est de créer une interface de gestion et de requête de cette base mais aussi de visualisation des résultats.",
"A titre d’exemple la figure ci-contre illustre une représentation dynamique des résultats d’une base de données ",
"sur les supplémentsalimentaires . L’exploration facile et visuelle de la base des MGS proposé dans ce projet devrait",
"permettre aux chercheurs de l’Institut du Cardiométabolisme et de la Nutrition d’accélérer leur recherche sur le rôle important",
"des bactéries intestinales dans ",sep="\n")
      progress$inc(1/2)
      return(paste(contexte,objectif,sep="\n"))
    })
    
    
  }