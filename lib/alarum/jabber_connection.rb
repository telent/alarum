class Alarum::JabberConnection
  def self.new_from_yaml(xmpp)
    self.new(debug: xmpp['debug'],
             server: xmpp['server'],
             jid: xmpp['jid'],
             password: xmpp['password'].unpack('m').first)
  end
  def initialize(args)
    Jabber::debug = args[:debug]
    jid = Jabber::JID.new(args[:jid])
    @client = Jabber::Client.new(jid).tap {|c|
      c.allow_tls = false         # xmpp4r won't reliably connect to my ejabberd with this enabled
      c.connect(args[:server])
      c.auth(args[:password])
      c.send(Jabber::Presence.new.set_type(':available'))
    }
  end
  def alert(recipient, m)
    message = Jabber::Message.new(recipient, m).set_type(:chat)
    warn [Time.now, m]
    @client.send message
  end
end
