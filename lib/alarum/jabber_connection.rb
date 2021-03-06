require 'xmpp4r'

class Alarum::JabberConnection
  def self.new_from_yaml(xmpp)
    self.new(debug: xmpp['debug'],
             allow_tls: xmpp['allow_tls'],
             server: xmpp['server'],
             jid: xmpp['jid'],
             password: xmpp['password'].unpack('m').first)
  end
  def initialize(args)
    Jabber::debug = args[:debug]
    jid = Jabber::JID.new(args[:jid])
    @client = Jabber::Client.new(jid).tap {|c|
      c.allow_tls = args[:allow_tls]
      c.connect(args[:server])
      c.auth(args[:password])
      c.send(Jabber::Presence.new.set_type(':available'))
    }
  end
  def alert(m, recipients)
    warn [Time.now, m]
    Array(recipients).each do |r|
      message = Jabber::Message.new(r, m).set_type(:chat)
      @client.send message
    end
  end
end
