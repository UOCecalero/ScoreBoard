//
//  PlayerDetail.swift
//  ScoreBoard
//
//  Created by Edu Calero on 08/08/2020.
//  Copyright © 2020 Iflet.tech. All rights reserved.
//

import SwiftUI

struct PlayerDetail: View {
    
    var temporadas = ["19/20", "18/19", "17/18", "Histórico"]
    @State var id: Int
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Player Name")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    Spacer()
                }
                PlayerCard()
                
                HStack{
                    Text("Estadísticas")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)
                    Spacer()
                }
                Picker(selection: .constant(1), label: Text("TemporadasPicker")) {
                    ForEach(0 ..< temporadas.count) { index in
                        Text(self.temporadas[index]).tag(index)
                    }
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                StatisticsCard()
            }
            
            HStack{
                Text("Títulos")
                .font(.largeTitle)
                .fontWeight(.bold)
                    .padding(.horizontal)
                Spacer()
            }
        }
        
        
        
        
    }
}

struct PlayerDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetail(id: 154)
    }
}

struct PlayerCard: View {
    var body: some View {
        VStack {
            Image("player_demo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
                .clipped()
                .cornerRadius(10.0)
                .padding(.top, 35)
            VStack {
                HStack{
                    Text("Nombre Completo:")
                        .bold()
                    Text("Luis Figo")
                    Spacer()
                }
                .padding(.horizontal)
                HStack{
                    Text("Edad:")
                        .bold()
                    Text("43 años")
                    Spacer()
                }
                .padding(.horizontal)
                HStack{
                    Text("Posición :")
                        .bold()
                    Text("Extremo")
                    Spacer()
                }
                .padding(.horizontal)
                HStack{
                    Text("Nacionalidad :")
                        .bold()
                    Text("Portugués")
                    Spacer()
                }
                .padding(.horizontal)
                HStack{
                    Text("Equipo Actual :")
                        .bold()
                    Text("Retirado")
                    Spacer()
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
    }
}

struct StatisticsCard: View {
    var body: some View {
        VStack{
            Group{
                HStack{
                    Text("Goles:")
                        .bold()
                    Text("15")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)

                HStack{
                    Text("Asistencias:")
                        .bold()
                    Text("15")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)
                
                //Aqui faltan las asistencias
                HStack{
                Text("Pases:")
                        .bold()
                    Text("262")
                    Text("(Acertados: 62%)")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)
                
                HStack{
                    Text("Tackles :")
                        .bold()
                    Text("Total: 3")
                    Text("(Efectividad: 75%)")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)
                
                HStack{
                    Text("Duelos :")
                        .bold()
                    Text("122")
                    Text("(Efectividad: 56%)")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)
                
                HStack{
                    Text("Regates :")
                        .bold()
                    Text("54")
                    Text("Efectividad: 54%")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)
            }
            
            Group{
                HStack{
                    Text("Faltas Recibidas:")
                        .bold()
                    Text("7")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)
                HStack{
                    Text("Penaltys Recibidos:")
                        .bold()
                    Text("7")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)
                HStack{
                   Text("Penaltys Lanzados:")
                       .bold()
                   Text("7")
                   Text("Acierto: 50%")
                   Spacer()
               }
               .padding(.horizontal)
                .border(Color.gray, width: 0.3)
                HStack{
                   Text("Faltas Cometidas:")
                       .bold()
                   Text("2")
                    Spacer()
               }
               .padding(.horizontal)
                .border(Color.gray, width: 0.3)
                HStack{
                    Text("Tarjetas :")
                        .bold()
                    Text("2 Amarillas")
                    Text("0 Rojas")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)
            }
            Group {
                HStack{
                    Text("Penlatys :")
                        .bold()
                    Text("54")
                    Text("Efectividad: 54%")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)
                HStack{
                    Text("Partidos :")
                        .bold()
                    Text("54")
                    Text("(Efectividad: 54%)")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)
                HStack{
                    Text("Sustituciones :")
                        .bold()
                    Text("54")
                    Text("Efectividad: 54%")
                    Spacer()
                }
                .padding(.horizontal)
                .border(Color.gray, width: 0.3)
            }
        }
        .padding(.vertical)
    }
}
