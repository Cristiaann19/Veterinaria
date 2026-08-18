import {Component} from '@angular/core';
import {AboutSection} from './about-section/about-section';
import {ServicesSection} from './services-section/services-section';
import {FAQSection} from './faqsection/faqsection';
import {ContactSection} from './contact-section/contact-section';
import {ReviewsSection} from './reviews-section/reviews-section';
import {FooterSection} from './footer-section/footer-section';

@Component({
  selector: 'app-sections',
  standalone: true,
  imports: [AboutSection, ServicesSection, FAQSection, ContactSection, ReviewsSection, FooterSection],
  templateUrl: './sections.html',
})
export class Sections {

}
