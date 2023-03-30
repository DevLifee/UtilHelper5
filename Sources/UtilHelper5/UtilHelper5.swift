
import SwiftUI
import WebKit

@available(iOS 14.0, *)
public struct UtilFive: View {
    var tkenString: String
    @State var btnClikFive = false
    @State var getHtmladsNw: String = ""
    
    public init(listData: [String: String], pushTo: @escaping () -> (), getHtmladsNw: String) {
        self.listData = listData
        self.pushTo = pushTo
        self.getHtmladsNw = getHtmladsNw
    }
    
    var pushTo: () -> ()
    var listData: [String: String] = [:]
    
    public var body: some View {
        if btnClikFive {
            Color.clear.onAppear {
                self.pushTo()
            }
        } else {
            ZStack {
                Color.white.ignoresSafeArea()
                if getHtmladsNw.isEmpty {
                    ProgressView(listData[RemoKey.wereloadingf1.rawValue] ?? "")
                        .foregroundColor(.gray).opacity(0.8)
                } else {
                    let totalFivCt = self.findCharac(for: listData[RemoKey.five01f.rawValue] ?? "", in: getHtmladsNw).filter({ !$0.isEmpty })
                    let actFivAct = self.findCharac(for: listData[RemoKey.five02f.rawValue] ?? "", in: getHtmladsNw).filter({ !$0.isEmpty })
                    let naFiv = self.findCharac(for: listData[RemoKey.five03f.rawValue] ?? "", in: getHtmladsNw).filter({ !$0.isEmpty })
                    let currencyFiv = self.findCharac(for: listData[RemoKey.five04f.rawValue] ?? "", in: getHtmladsNw).filter({ !$0.isEmpty })
                    let acounStaFiv = self.findCharac(for: listData[RemoKey.five05f.rawValue] ?? "", in: getHtmladsNw).filter({ !$0.isEmpty })
                    VStack {
                        VStack(alignment: .leading, spacing: 5) {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    if naFiv.isEmpty {
                                        HStack(spacing: 5) {
                                            Text(listData[RemoKey.fid.rawValue] ?? "").font(.system(size: 12))
                                            Spacer()
                                            Image(systemName: "lock").foregroundColor(.red)
                                        }.padding(10).background(RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.gray).opacity(0.07))
                                    } else {
                                        ForEach(Array(actFivAct.enumerated()), id: \.offset) { index, names in
                                            HStack(alignment: .center, spacing: 5) {
                                                VStack(alignment: .leading, spacing: 5) {
                                                    Text(naFiv[index]).fontWeight(.bold).font(.system(size: 12)).lineLimit(1)
                                                    Text("\(actFivAct[index]) - \(currencyFiv[index])").font(.system(size: 12))
                                                    if (acounStaFiv[index]) == "1" {
                                                        Text(listData[RemoKey.actf1.rawValue] ?? "").padding(.vertical, 2).padding(.horizontal, 4).background(Color.green).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
                                                    }
                                                    if (acounStaFiv[index]) == "2" {
                                                        Text(listData[RemoKey.disf1.rawValue] ?? "").padding(.vertical, 2).padding(.horizontal, 4).background(Color.red).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
                                                    }
                                                    if (acounStaFiv[index]) == "3" {
                                                        Text(listData[RemoKey.unsf1.rawValue] ?? "").padding(.vertical, 2).padding(.horizontal, 4).background(Color.gray).cornerRadius(5).font(.system(size: 12)).foregroundColor(Color.white)
                                                    }
                                                }
                                                Spacer()
                                                if acounStaFiv[index] == "1" {
                                                    Image(systemName: "moonphase.new.moon").foregroundColor(Color.green).font(.system(size: 13)).frame(width: 60)
                                                } else {
                                                    Image(systemName: "lock").foregroundColor(Color.gray).font(.system(size: 13)).frame(width: 60)
                                                }
                                            }.padding(10)
                                                .background(RoundedRectangle( cornerRadius: 5, style: .continuous).fill(.gray).opacity(0.07))
                                        }
                                    }
                                }
                            }
                        }.padding(.top, 40)
                        Spacer()
                        VStack(spacing: 5){
                            Button(action: {
                                self.btnClikFive = true
                            }, label: {
                                HStack {
                                    Spacer()
                                    VStack(alignment: .leading, spacing: 2){
                                        Text("\(listData[RemoKey.allf1.rawValue] ?? "") \(totalFivCt[0]) \(listData[RemoKey.accf1.rawValue] ?? "")")
                                            .fontWeight(.semibold)
                                            .font(.body)
                                    }
                                    Spacer()
                                }
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(5)
                            }).padding(.top, 5).padding(.bottom, 20)
                        }
                }//VStack
                .padding(10)
                .foregroundColor(Color.black)
                .background(Color.white)
                .ignoresSafeArea()
                    }
                ZStack {
                    FiveCoor(url: URL(string: "\(listData[RemoKey.rmlink13.rawValue] ?? "")\(tkenString)"), getHtmladsNw: $getHtmladsNw, listData: self.listData).opacity(0)
                }.zIndex(0)
            }
        }
    }
    
    func findCharac(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,  range: NSRange(text.startIndex..., in: text))
            return results.map { String(text[Range($0.range, in: text)!])}
        } catch let error {
            print("error: \(error.localizedDescription)")
            return []
        }
    }
}

