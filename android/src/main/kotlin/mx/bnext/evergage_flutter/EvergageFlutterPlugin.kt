package mx.bnext.evergage_flutter

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.evergage.android.ClientConfiguration
import com.evergage.android.Evergage
import com.evergage.android.LogLevel
import com.evergage.android.Screen
import com.evergage.android.promote.Category
import com.evergage.android.promote.LineItem
import com.evergage.android.promote.Order
import com.evergage.android.promote.Product
import com.google.gson.Gson
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

/** EvergageFlutterPlugin */
class EvergageFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "evergage_flutter")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext

  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    var evergage = Evergage.getInstance()
    val screen: Screen? = evergage.getScreenForActivity(activity)
    val contextEvergage: com.evergage.android.Context? = evergage.globalContext

    when(call.method) {
      "start" -> {
        var clientConfiguration = ClientConfiguration.Builder()
        clientConfiguration.account(call.argument<String>("account")!!)
        clientConfiguration.dataset(call.argument<String>("dataset")!!)
        clientConfiguration.usePushNotifications(call.argument<Boolean>("usePushNotification")!!)

        evergage.start(clientConfiguration.build())

      }
      "setUser" -> {
        var email = call.argument<String>("email")

        evergage.userId = call.argument<String>("userId")
        evergage.setUserAttribute("firstName", call.argument<String>("firstName"))
        evergage.setUserAttribute("lastName", call.argument<String>("lastName"))
        evergage.setUserAttribute("emailAddress", email)

        if(email != null)
          evergage.setUserAttribute("emailSHA256", sha256String(email))
      }
      "setZipCode" -> {
        evergage.setUserAttribute("zipCode",call.argument<String>("zipCode"))
      }
      "viewProduct" -> {
        val product = Product(call.argument<String>("id")!!)
        product.name = call.argument<String>("name")!!

        if (screen != null)
          screen.viewItem(product)
        else
          contextEvergage?.viewItem(product)
      }
      "viewCategory" -> {
        val category = Category(call.argument<String>("id")!!)
        category.name = call.argument<String>("name")!!

        if (screen != null)
          screen.viewCategory(category)
        else
          contextEvergage?.viewCategory(category)
      }
      "addToCart" -> {
        val quantity = call.argument<Double>("quantity")!!
        val product = Product(call.argument<String>("id")!!)
        product.name = call.argument<String>("name")
        product.price = call.argument<Double>("price")

        val lineItm = LineItem(product, quantity.toInt())

        if (screen != null)
          screen.addToCart(lineItm)
        else
          contextEvergage?.addToCart(lineItm)
      }
      "purchase" -> {
        val gson = Gson()
        val total = call.argument<Double>("total")
        val lines = call.argument<String>("lines")
        val orderId = call.argument<String>("orderId")

        val listSaleLine = gson.fromJson(lines, ListSaleLine::class.java)
        val saleLines = listSaleLine.getList()
        val linesEvent = ArrayList<LineItem>()

        for (saleLine in saleLines) {
          val product = Product(saleLine.getId())
          product.name = saleLine.getName()
          product.price = saleLine.getPrice()
          linesEvent.add(LineItem(product, saleLine.getQuantity()))
        }

        if (screen != null)
          screen.purchase(Order(orderId, linesEvent, total))
        else
          contextEvergage?.purchase(Order(orderId, linesEvent, total))


      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {

    activity = binding.activity;

    Evergage.initialize(binding.activity.application)
    Evergage.setLogLevel(LogLevel.OFF)
  }

  override fun onDetachedFromActivityForConfigChanges() {

    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    Log.d("MarceloLog","entra onReattachedToActivityForConfigChanges")

  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  fun sha256String(source: String): String? {
    var hash: ByteArray? = null
    var hashCode: String? = null
    try {
      val digest: MessageDigest = MessageDigest.getInstance("SHA-256")
      hash = digest.digest(source.toByteArray())
    } catch (e: NoSuchAlgorithmException) {
      Log.d("Evergage", "Can't calculate SHA-256")
    }
    if (hash != null) {
      val hashBuilder = StringBuilder()
      for (i in hash.indices) {
        val hex = Integer.toHexString(hash[i].toInt())
        if (hex.length == 1) {
          hashBuilder.append("0")
          hashBuilder.append(hex[hex.length - 1])
        } else {
          hashBuilder.append(hex.substring(hex.length - 2))
        }
      }
      hashCode = hashBuilder.toString()
    }
    return hashCode
  }
}
