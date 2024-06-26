import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/domain/models/review.dart';
import 'package:skill_trade/domain/models/technician.dart';
import 'package:skill_trade/presentation/widgets/editable_textfield.dart';
import 'package:skill_trade/presentation/widgets/technician_profile.dart';
import 'package:skill_trade/presentation/widgets/rating_stars.dart';
import 'package:skill_trade/application/blocs/bookings_bloc.dart';
import 'package:skill_trade/presentation/events/bookings_event.dart';
import 'package:skill_trade/application/blocs/customer_bloc.dart';
import 'package:skill_trade/presentation/events/customer_event.dart';
import 'package:skill_trade/presentation/states/customer_state.dart';
import 'package:skill_trade/application/blocs/review_bloc.dart';
import 'package:skill_trade/presentation/events/review_event.dart';
import 'package:skill_trade/presentation/states/review_state.dart';
import 'package:skill_trade/infrastructure/storage/storage.dart';

class MyBookings extends StatefulWidget {
  final Technician technician;

  const MyBookings({super.key, required this.technician});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  late DateTime? _selectedDate = null;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date selected
      firstDate: DateTime(2010), // First selectable date
      lastDate: DateTime(2050), // Last selectable date
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  int _rating = 0;
  TextEditingController _reviewController = TextEditingController();
  TextEditingController serviceNeededController = TextEditingController();
  TextEditingController serviceLocationController = TextEditingController();
  TextEditingController problemDescriptionController = TextEditingController();


  void _submitReview() async {
    BlocProvider.of<ReviewsBloc>(context).add(PostReview(technicianId: widget.technician.id, review: _reviewController.text, rate: _rating, customerId: int.tryParse((await SecureStorage.instance.read("id"))!)!));
    _reviewController.clear();
    setState(() {
      _rating = 0;
    });
  }

  void submitBooking() async {
    BlocProvider.of<BookingsBloc>(context).add(PostBooking(problemDescription: problemDescriptionController.text, customerId: int.tryParse((await SecureStorage.instance.read("id"))!), technicianId: widget.technician.id, serviceNeeded: serviceNeededController.text, serviceDate: _selectedDate!, serviceLocation: serviceLocationController.text));
    serviceNeededController.clear();
    serviceLocationController.clear();
    problemDescriptionController.clear();
    setState(() {
        _selectedDate = null;
    });
  }
  
  String? id;
  Future<void> loadId(context) async {
    String? id = await SecureStorage.instance.read("id");
    BlocProvider.of<CustomerBloc>(context).add(LoadCustomer(customerId: id!));
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReviewsBloc>(context).add(LoadTechnicianReviews(technicianId: widget.technician.id));
    loadId(context);
    return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Technician",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              TechnicianSmallProfile(technician: widget.technician,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Book Service",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Service \nDate:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : '${_selectedDate.toString().substring(0, 10)}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            // SizedBox(height: 20),
                            TextButton(
                              onPressed: () => _selectDate(context),
                              child: const Text('Select Date'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Service \nNeeded:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        SizedBox(
                          width: 220,
                          height: 40,
                          child: TextField(
                            controller: serviceNeededController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Service Needed",
                              labelStyle: TextStyle(
                                color: Colors.transparent
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Service \nLocation:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        SizedBox(
                          width: 220,
                          height: 40,
                          child: TextField(
                            controller: serviceLocationController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Service Location",
                              labelStyle: TextStyle(
                                color: Colors.transparent
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Problem \nDescription:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        SizedBox(
                          width: 220,
                          height: 60,
                          child:  TextField(
                            controller: problemDescriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Problem Description",
                              labelStyle: TextStyle(
                                color: Colors.transparent
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 250,
                      child:  TextButton(
                          onPressed: submitBooking,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                          ),
                          child: const Text(
                            "Book",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
        // This is the review seciton
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Previous reviews
                    const Text(
                      'Reviews',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<ReviewsBloc, ReviewsState>(
                      builder: (context, state) {
                        if (state is ReviewsLoaded) {
                         return state.reviews.isNotEmpty ? Container(
                            height: state.reviews.length * 150,
                            child: ListView.builder(
                              itemCount: state.reviews.length,
                              itemBuilder: (context, index) {
                                Review curReview = state.reviews[index];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/profile.jpg",
                                          width: 40,
                                          height: 40,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          state.reviews[index].customer,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      title: RatingStars(
                                          rating: state.reviews[index].rating),
                                      subtitle: BlocBuilder<CustomerBloc, CustomerState>(
                                          builder: (context, state) {
                                            if (state is CustomerLoaded) {
                                              if (state.customer.id == curReview.customerId) {
                                                TextEditingController curController = TextEditingController();
                                                curController.text = curReview.comment;
                                                return Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    EditableField(data: curReview.comment, controller: curController, label: 'review,${curReview.id},${widget.technician.id}',),
                                                    IconButton(
                                                      onPressed: () {
                                                        BlocProvider.of<ReviewsBloc>(context).add(DeleteReview(reviewId: curReview.id, technicianId: widget.technician.id, ));
                                                      }, 
                                                      icon: const Icon(Icons.delete, color: Colors.red, ))
                                                  ],
                                                );
                                              } else {
                                                return Text(curReview.comment);
                                              }
                                            } else {
                                              return Text(curReview.comment);
                                            }
                                          }
                                      )
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                          :const Text(
                            "No reviews yet!",
                          );
                          } else if (state is ReviewsLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is ReviewsError) {
                            return Center(child: Text(state.error));
                          } else {
                            return Container();
                          }
                      }
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Leave a Review',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // Star rating widget
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.star,
                              color: _rating >= 1 ? Colors.orange : Colors.grey),
                          onPressed: () => setState(() => _rating = 1),
                        ),
                        IconButton(
                          icon: Icon(Icons.star,
                              color: _rating >= 2 ? Colors.orange : Colors.grey),
                          onPressed: () => setState(() => _rating = 2),
                        ),
                        IconButton(
                          icon: Icon(Icons.star,
                              color: _rating >= 3 ? Colors.orange : Colors.grey),
                          onPressed: () => setState(() => _rating = 3),
                        ),
                        IconButton(
                          icon: Icon(Icons.star,
                              color: _rating >= 4 ? Colors.orange : Colors.grey),
                          onPressed: () => setState(() => _rating = 4),
                        ),
                        IconButton(
                          icon: Icon(Icons.star,
                              color: _rating >= 5 ? Colors.orange : Colors.grey),
                          onPressed: () => setState(() => _rating = 5),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Text input for review
                    TextField(
                      controller: _reviewController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Write your review here...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Submit button
                    ElevatedButton(
                      onPressed: _submitReview,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}


