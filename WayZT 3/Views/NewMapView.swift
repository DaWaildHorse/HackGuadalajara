//
//  NewMapView.swift
//  WayZT 3
//
//  Created by Ultiimate Dog on 02/04/25.
//

import SwiftUI
import MapKit

struct NewMapView: View {
    // MARK: - ATTRIBUTES
    @State private var position : MapCameraPosition = .region(.userRegion)
    @State private var results: [Mapa] = []
    @State private var POISelection : MKMapItem?
    @State private var details = false
    @State private var getDirections = false
    @State private var route : MKRoute?
    @State private var routeView = false
    @State private var Destination : MKMapItem?
    
    @State private var included: [String] = []
    private let categories = ["Recycle", "Organic", "Electronic", "Glass"]
    private let icons = ["waterbottle", "carrot", "macbook.and.iphone", "wineglass"]
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: - MAPS
            Map(position: $position , selection: $POISelection){
                UserAnnotation()
                
                ForEach(results) { mapa in
                    if included.contains(mapa.category) {
                        Marker("Puntos de reciclaje", systemImage : mapa.icon ,coordinate: mapa.map.placemark.coordinate)
                            .tint(mapa.color)
                            .tag(mapa.map)
                    }
                }
                
                if let route{
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 8)
                }
                
            }
            .mapControls{
                MapUserLocationButton()
                MapPitchToggle()
            }
            .onAppear {
                CLLocationManager().requestWhenInUseAuthorization()
                Task {
                    convertCoordinates()
                }
            }
            .onChange(of: POISelection, {oldValue , newValue in
                details = newValue != nil
            })
            .onChange(of: getDirections, {oldValue , newValue in
                if newValue{
                    fetchRoute()
                }
            })
            .sheet(isPresented: $details, content: {POIdetails(mapSelection: $POISelection, showDetail: $details, getDirections: $getDirections)
                    .presentationDetents([.medium])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                    .presentationCornerRadius(20)
            })
            
            TagBar()
            
        }//: ZSTACK
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    // MARK: - PILL
    func TagPill(_ text: String, selected: Bool) -> some View {
        Text(text)
            .fontWeight(.heavy)
            .foregroundStyle(.second)
            .padding(.horizontal)
            .frame(height: 30)
            .background(
                Capsule()
                    .fill(selected ? .accent : .mainBackground)
            )
        
    }
    
    // MARK: - TAGS
    func TagBar() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(categories, id:\.self) { cat in
                    Button {
                        withAnimation(.spring(duration: 0.3, bounce: 0.4)) {
                            addCat(cat)
                        }
                    } label: {
                        TagPill(cat, selected: included.contains(cat))
                            .scaleEffect(included.contains(cat) ? 1 : 0.9)
                            .padding(.horizontal, included.contains(cat) ? 5 : 0)
                    }
                }//: FOR EACH
            }
            .padding(5)
            .padding(.trailing, 5)
            .background(
                .ultraThinMaterial
            )
            .clipShape(Capsule())
        }
        .clipShape(Capsule())
        .padding(8)
        .padding(.trailing, 45)
    }
    
    // MARK: - ADD
    func addCat(_ cat: String) {
        if included.contains(cat) {
            included.remove(at: included.firstIndex(of: cat)!)
        } else {
            included.append(cat)
        }
    }
    
    // MARK: - CONVERT
    func convertCoordinates() {
        var newResults: [Mapa] = []
            
        for coordinate in coordinatesRecyclable {
            let mapItem = createMapItem(from: coordinate)
            
            newResults.append(Mapa(map: mapItem))
        }
            
        results = newResults
    }
    
    private func createMapItem(from coordinate: CLLocationCoordinate2D) -> MKMapItem {
        let placemark = MKPlacemark(coordinate: coordinate)
        return MKMapItem(placemark: placemark)
    }
    
    // MARK: - FETCH
    func fetchRoute(){
        if let POISelection{
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: .userLocation))
            request.destination = POISelection
            
            Task{
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                Destination = POISelection
                
                withAnimation(.snappy){
                    routeView = true
                    details = false
                    
                    if let rect = route?.polyline.boundingMapRect, routeView{
                        position = .rect(rect)
                    }
                }
            }
        }
    }
}

#Preview {
    NewMapView()
        .background(.red)
}
