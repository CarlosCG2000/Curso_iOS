//
//  SitiosFavoritos.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 3/1/25.
//

import SwiftUI
import MapKit // para los mapas

// VISTA PRINCIPAL: SitiosFavoritos
struct SitiosFavoritos: View {
    // _______________  VARIABLES _______________
    // @State: son propiedades reactivas que permiten que las vistas de SwiftUI se actualicen automáticamente cuando cambian sus valores.
    // 'MapCameraPosition.region': define la posición inicial de la cámara del mapa y especifica una región para centrar el mapa
    @State var position = MapCameraPosition.region(
        // 'MKCoordinateRegion': define una región basada en un centro (coordenadas) y un "span" que controla el nivel de zoom.
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:40.41 , longitude:-3.70),
                           span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    )
    
    // Almacena una lista de lugares que se mostrarán en el mapa. (Place, es la estructura definida en el fichero Place)
    @State var places:[Place] = []
    
    // Que el showPopUp contenga las coordenadas (como si fuera true) o sea nil (como si fuera false) y asi no utilizo un booleano sin mas y obtengo directamente  las coordenadas, para mostrar el dialogo o no.
    @State var showPopUp:CLLocationCoordinate2D? = nil
    
    // Dentro del dialogo los datos que pone el usuario en el formulario.
    @State var name:String = ""
    @State var fav:Bool = false
    // Los posibles mensajes de error que salen en el formulario. del dialogo
    @State private var showError: Bool = false // variable para mostrar el error
    @State private var errorMessage: String = "" // variable para mostrar el mensaje de error
    
    // Para mostrar el listado
    @State var showSheet:Bool = false
    
    // Caracterisricas del Sheet
    let heightPersonalizada = stride(from: 0.3, through: 0.3, by: 0.1) // tamaño fijo del sheet, donde va a empezar el boton sheet cuando salga, cual va a ser la altura maxima, cuanto sube cuando hacemos scroll
        .map{ PresentationDetent.fraction($0)} // para que calcule el tamaño y no se vuelva loco
    // ____________________________________________________________
    
    var body: some View {
        
        ZStack { // ZStack principal
        
            // ___________________ Mapa entero de la pantalla  _______________________
            // MapReader: Proporciona un contexto para interactuar con el mapa.
            MapReader { proxy in // el objeto proxy permite convertir coordenadas entre diferentes sistemas (por ejemplo, de pantalla a coordenadas geográficas).
                Map(position: $position) // Renderiza un mapa que se centra en la posición definida por la variable position
                {
                   // Pintar con un marcador que da la posición de los lugares favoritos
                    ForEach(places){ place in
                        // Se crea el marcador
                        Annotation(place.name, coordinate: place.coordinates){
                            let color = place.fav ? Color.orange : Color.red // si esta en favoritos o no cambia el color
                            let icono = place.fav ? "star.fill" : "star.slash.fill"
                            
                            Image(systemName: icono)
                                .foregroundStyle(color)
                                .frame(width:80)
                        }
                    }
                }
                //... Atributos del Map
                .mapStyle(.standard) //Tipos de mapas: standard, hybrid, imagery - showsTraffic: true --> el estado de las carreteras, etc
                .onTapGesture { coord in // onTapGesture: Manejo de Toques (Gestos)
                
                    if let coordinates = proxy.convert(coord, from: .local) // Convierte las coordenadas del toque (en el sistema de vista local) a coordenadas geográficas (CLLocationCoordinate2D).
                    {
                        // nos da las coordenadas para que se guarden cuando se toque la pantalla y salga el dialogo
                        showPopUp = coordinates
                    }
                
                }
                .overlay { // Capa Superpuesta
                    VStack {
                        Button("Show list") { // botón para activar el Sheet
                            showSheet = true // se activa el listado de lugares (controlado por showSheet).
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.cyan.opacity(0.8))
                        .foregroundStyle(.black)
                        .cornerRadius(16)
                        .padding(16)
                        Spacer()
                    }
                }
            }
            // ____________________________________________________________
            
            // ___________________ Dialogo con formulario para guardar un nuevo lugar _______________________
            // Cuando se muestre el dialogo llame al CustomDialog (cuando se pulsa en el mapa y se guardan sus coordenadas)
            if showPopUp != nil {
                
                //  """""""""""""" La variable de la vista entera para el dialogo """"""""""""""
                let view = VStack{
                    Spacer()
                    Text("Añadir localización").font(.title2).bold()
                    Spacer()
                    TextField("Nombre", text: $name) // input de text
                            .textFieldStyle(RoundedBorderTextFieldStyle()) // Mejora el estilo del campo
                            .overlay( // superponer
                                RoundedRectangle(cornerRadius: 5) // el border de forma redondeada
                                    .stroke(showError ? Color.red : Color.clear, lineWidth: 2) // resaltar borde si hay error
                            )
                          
                    // Si hay error en el input (por dejarlo vacio)
                    if showError {
                        HStack {
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                            Spacer() // Agrega espacio después para empujar el texto hacia la izquierda
                        }
                    }
                    
                    Toggle("¿Es un lugar favorito?", isOn: $fav)
                    Spacer()
                    Spacer()
                    Button("Guardar"){ // LA ACCIÓN CUANDO SE DA A GUARDAR
                        if name.isEmpty {
                            errorMessage = "El nombre no puede estar vacío."
                            showError = true
                        } else if name.count <= 3 {
                            errorMessage = "El nombre debe tener más de 3 caracteres."
                            showError = true
                        } else {
                            savePlace(name:name, fav: fav, coordinates: showPopUp!) // 1_función para guardar el lugar
                            clearForm() // 2_función para que limpie el input y toogle del formulario y que me cierre el dialogo
                        }
                    }
                }
                // """"""""""""""""""""""""""""""""""""""""""""""""""""""""
                
                // Se llama al fichero de CustomDialog para que se muestre el dialogo, a traves de la vista justo antes creada
                withAnimation { // para que rediriga de forma mas bonita y no sea de golpe
                    CustomDialog(closeDialog: { showPopUp = nil }, // función para cerrar el dialogo
                                 onDismissOutside: true, // si quiero que se pueda cerrar desde fuera del dialogo o no
                                 content:view) // la vista con los elementos que se van a encontrar en el dialogo
                }
            }
            // ____________________________________________________________
            
        // ___________________ Mostrar el listado horizontal de lugares guardados _______________________
        }
        //... Atributos de ZStack principal
        .sheet(isPresented: $showSheet){
            ZStack { // ZStack secundario
                // CREAR LA LISTA HORIZONTAL DE LOS LUGARES FAVORITOS
                ScrollView(.horizontal){ // scrooll horizontal (por defecto es vertical)
                    LazyHStack{ // listado horizontal
                        ForEach(places){ place in
                            let color = place.fav ? Color.yellow : Color.red
                            
                            VStack { // VStack secundario
                                Text(place.name)
                                    .font(.title)
                                    .bold()
                                
                            }
                            //... Atributos de VStack secundario
                            .frame(width: 150, height: 100)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20).stroke(color, lineWidth: 2)
                            }
                            .shadow(radius: 10)
                            .padding(.horizontal, 8)
                            .onTapGesture { // podemos controlar el click del elemento para que nos lleve a su dirección
                                animateCamera(coord: place.coordinates) // 3_función personalizada definida
                                showSheet = false
                            }
                        }
                        
                    }
                }
                
            }
            //... Atributos de ZStack secundario
            .presentationDetents(Set(heightPersonalizada)) // las dimesiones personalizadas para el Sheet
            
        }
        //... Atributos de Sheet
        .onAppear(){ // cuando aparezca la vista
            cargarPlaces() // se llamara a la extensión 'BD_UserDefaults' que contiene la funcion cargarPlaces(), para cargar los places guardados
        }
        // ____________________________________________________________
    }
    
    // ================================= FUNCIONES (3) =================================
    
    // 1_Función guardar (dentro de la estructura porque es para ella)
    func savePlace(name:String, fav: Bool, coordinates: CLLocationCoordinate2D){
        if name == "" {
            return
        }
        
        let place = Place(name: name, coordinates: coordinates,  fav: fav)
        places.append(place)
        guardarPlaces() // reemplaza y guardarllamando a la extensión 'BD_UserDefaults' los places para tenerlo de manera persistente
    }
    
    // 2_Función para limpiar el formulario y cerrar el Pop Up, una vez guardado
    func clearForm() {
        name = ""
        fav = false
        showPopUp = nil
    }
    
    // 3_Función que a través de unas coordenadas te redirige a la posición en el mapa
    func animateCamera(coord:CLLocationCoordinate2D) {
        withAnimation {
            position = MapCameraPosition.region(
                MKCoordinateRegion(center: coord,
                                   span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            )
        }
    }
}

#Preview {
    SitiosFavoritos()
}
