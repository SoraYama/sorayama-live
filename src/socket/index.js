import openSocket from 'socket.io-client'

const socketHost = process.env.NODE_ENV === 'production' ?
'http://www.sorayamah.org:2020' :
'http://localhost:2020'

const socket = openSocket(socketHost);

export default socket
