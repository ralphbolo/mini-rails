App.chat = App.cable.subscription.create "ChatChannel",
  connected: ->

  disconnected: ->


  received: (data) -> 
    entry = document.createElement("li")
    entry.innerText = data.message
    document.getElementById("chat").appendChild(entry)