/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

let emoji = "🐍,👍,💄,🎏,🐠,🍔,🏩,🎈,🐷,👠,🐣,🐙,✈️,💅,⛑,👑,👛,🐝,🌂,🌻,🎼,🎧,🚧,📎,🍻".components(separatedBy: ",")


class DataStore {
  private var emojiRatings = emoji.map { EmojiRating(emoji: $0, rating: "") }
  
  public var numberOfEmoji: Int {
    return emojiRatings.count
  }
  
//  public func loadEmojiRating(at index: Int) -> EmojiRating? {
//    if (0..<emojiRatings.count).contains(index) {
//        
//      //随机延迟,对网络的模拟
//      let randomDelayTime = Int.random(in: 500..<2000)
//      usleep(useconds_t(randomDelayTime * 1000))
//      return emojiRatings[index]
//    }
//    return .none
//  }
    public func loadEmojiRating(at index: Int) -> DataLoadOperation? {
      if (0..<emojiRatings.count).contains(index) {
        return DataLoadOperation(emojiRatings[index])
      }
      return .none
    }


    
    
  //替换具有相同emoji的对象元素,可能是用于更新rating
  public func update(emojiRating: EmojiRating) {
    if let index = emojiRatings.index(where: { $0.emoji == emojiRating.emoji }) {
      emojiRatings.replaceSubrange(index...index, with: [emojiRating])
    }
  }
}


class DataLoadOperation: Operation {
  // 1
  var emojiRating: EmojiRating?
  var loadingCompleteHandler: ((EmojiRating) -> Void)?
  
  private let _emojiRating: EmojiRating
  
  // 2构造函数
  init(_ emojiRating: EmojiRating) {
    _emojiRating = emojiRating
  }
  
  // 3
  override func main() {
    // TBD: Work it!!
      // 1如果已经被取消,return,内置在operation里面
      if isCancelled { return }
          
      // 2模拟网络请求
      let randomDelayTime = Int.random(in: 500..<2000)
      usleep(useconds_t(randomDelayTime * 1000))

      // 3如果已经被取消
      if isCancelled { return }

      // 4模拟网络请求成功
      emojiRating = _emojiRating

      // 5异步调用completion handler
      if let loadingCompleteHandler = loadingCompleteHandler {
        DispatchQueue.main.async {
          loadingCompleteHandler(self._emojiRating)
        }
      }

  }
}
