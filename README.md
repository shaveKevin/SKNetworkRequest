# SKNetworkRequest
支持AFNetworking 3.x的 网络请求

包括单个请求和 多个请求(异步)

对网络请求进行封装的意义在于
* 可以根据不同业务进行请求的分级定制
* 可以在更换第三方框架的时候比如asi到afn的过程中 只需要改动少许代码就可以进行无缝切换
* 可以装B


## 思考

* 关于请求使用代理还是Block，我认为用代理好一点，因为代理能够更好的明确职责，并且容易跟踪。用block的话 耦合性低一点，不用写那么多代码。不足之处就是不容易进行代码追踪。江湖流传使用block比代理的逼格更高。当然使用block的时候一定要注意循环引用的问题。
