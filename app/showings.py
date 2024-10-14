# write endpoint to return the cinema for the showing, the hall for the showing, all the seats of the hall, and all available seats of the showing (to be considered available, 
# the seat must not appear on any ticket for the showing that has a status of 'active' or 'unpaid') 

#Example input: { 5e655dfd-b0ed-4854-bbf4-4ac44d44983c }        (the showing_id, as a uuid type)

# Example return/output: [
#     {                                                     (the cinema data)
#         id: '7524d45b-2502-4f4b-9a48-81b50003d414',
#         name: "Galaxy Theater",
#         address: "456 Oak Ave, Townsburg",
#         phone: "555-0200"
#     },
#     {                                                      (the hall data)
#         id: '364e54a8-0bbd-4773-a96e-00e718b477be',
#         cinema_id: '7524d45b-2502-4f4b-9a48-81b50003d414',
#         name: 'Hall C',
#         capacity: 70
#     },
#     [                                                      (the data of ALL seats in the hall)
#         {
#             id: '02446dcd-2b88-4683-975f-094ced7bf27e',
#             hall_id: '364e54a8-0bbd-4773-a96e-00e718b477be',
#             row: 'A',
#             number: '1',
#             type: 'standard'
#         },
#         {
#             id: '02abb836-af6e-4c0b-aca5-5e7503acd6b0',
#             hall_id: '364e54a8-0bbd-4773-a96e-00e718b477be',
#             row: 'B',
#             number: '2',
#             type: 'standard'
#         },
#         {
#             id: '053445d3-fba3-4287-81be-41f25be6e4de',
#             hall_id: '364e54a8-0bbd-4773-a96e-00e718b477be',
#             row: 'C',
#             number: '2',
#             type: 'standard'
#         },
#         and so on.....
#     ],
#     [                                                        (the data of all seats found to be available)
#         {
#             id: '05a350d1-8079-4a26-b4f5-afe65b536d51',
#             hall_id: '364e54a8-0bbd-4773-a96e-00e718b477be',
#             row: 'D',
#             number: '1',
#             type: 'standard'
#         },
#         {
#             id: '06deb63c-9e73-40f0-83b3-0e50c19ae7f5',
#             hall_id: '364e54a8-0bbd-4773-a96e-00e718b477be',
#             row: 'E',
#             number: '2',
#             type: 'standard'
#         },
#         {
#             id: '070f4648-629a-4012-a1a8-e650e05dffe6',
#             hall_id: '364e54a8-0bbd-4773-a96e-00e718b477be',
#             row: 'F',
#             number: '2',
#             type: 'standard'
#         },
#         and so on.....
#     ]
# ]