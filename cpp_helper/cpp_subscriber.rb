require 'cpp_helper_base'

class CppSubscriber < CppHelper 
	def initialize
		super
	end

	def create(className)
		#alert "100"
		@lines << "// This is the class header part of the Sunscriber"
		add_seperator
		@lines << ""
		@lines << String("" <<  "// Entity events that can be received by Subscribers of " << className)
		@lines << "enum Event"
		@lines << "{"
		@lines << "	EVENT_XXX"
		@lines << "	NUM_EVENTS"
		@lines << "};"
		@lines << ""
		@lines << "// Users can register for getting notifications on events be inheriting"
		@lines << "// Subscriber class and implementing the notify function	"
		@lines << "class Subscriber"
		@lines << "{"
		@lines << "public:"
		@lines << String("" <<  "	virtual void notify (" << className << "* pC" << className << ", Event eventId) {}")
		@lines << "};"
		@lines << ""
		@lines << "typedef std::list<Subscriber*>	SubscribersList;"
		@lines << ""
		@lines << "void addSubscriber(Event eventId, Subscriber* p);"
		@lines << "void removeSubscriber(Event eventId, Subscriber* p);"
		@lines << ""
		@lines << "private:"
		@lines << "void callEvent(Event eventId);"
		@lines << "void removeSubscriberIntern(Event eventId, Subscriber* p);"
		@lines << "void removeSubscribers();"
		@lines << ""
		@lines << "	typedef std::pair<Subscriber*, Event> SubscriberEventPair;"
		@lines << "	SubscribersList					m_vSubscribers[NUM_EVENTS];"
		@lines << "	std::list<SubscriberEventPair>	m_lSubscribersToRemove;"
		add_section_space	
		@lines << "// This header file body"
		add_seperator
		@lines << String("" << "inline void " << className << "::callEvent(" << className << "::Event eventId)")
		@lines << "{"
		@lines << "	removeSubscribers()"
		@lines << "	SubscribersList::iterator it = m_vSubscribers[eventId].begin();"
		@lines << "	for (; it != m_vSubscribers[eventId].end(); ++it)"
		@lines << "		(*it)->notify(this, eventId);"
		@lines << "}"
		@lines << ""
		@lines << String("" << "inline void " << className << "::addSubscriber(Event eventId, Subscriber* p)")
		@lines << "{"
		@lines << "	if (p)"
		@lines << "		m_vSubscribers[eventId].push_back(p);"
		@lines << "}"
		@lines << ""
		@lines << String("" << "inline void " << className << "::removeSubscriberIntern(Event eventId, Subscriber* p)")
		@lines << "{"
		@lines << "	m_vSubscribers[eventId].remove(p);"
		@lines << "}"
		@lines << ""
		@lines << String("" << "inline void " << className << "::removeSubscriber(Event eventId, Subscriber* p)")
		@lines << "{"
		@lines << "	m_lSubscribersToRemove.push_back(std::make_pair(p, eventId));"
		@lines << "}"
		@lines << ""
		@lines << String("" << "inline void " << className << "::removeSubscribers()")
		@lines << "{"
		@lines << "	std::list<SubscriberEventPair>::iterator iter = m_lSubscribersToRemove.begin();"
		@lines << "	for (; iter != m_lSubscribersToRemove.end(); ++iter)"
		@lines << "	{"
		@lines << "		removeSubscriberIntern((*iter).second, (*iter).first);"
		@lines << "	}"
		@lines << "	m_lSubscribersToRemove.clear();"
		@lines << "}"
		produce_output
	end
end

#obj = CppSubscriber.new
#obj.create("myXXX")
#obj.produce_output

